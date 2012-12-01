package maryfisher.util.animation {
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimationState;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.transitions.CrossfadeStateTransition;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.AnimatorEvent;
	import away3d.events.AssetEvent;
	import away3d.loaders.AssetLoader;
	import away3d.loaders.misc.AssetLoaderToken;
	import away3d.loaders.parsers.MD5AnimParser;
	import flash.utils.getQualifiedClassName;
	import maryfisher.framework.command.view.ViewCommand;
	import maryfisher.framework.view.ITickedObject;
	import maryfisher.view.core.BaseSpriteView;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAnimation extends BaseSpriteView implements IAnimation, ITickedObject{
		
		protected var _baseAnimator:BaseAnimator;
		protected var _animator:SkeletonAnimator;
		protected var _sequences:Vector.<SkeletonAnimationState>;
		protected var _currentSequences:Vector.<SkeletonAnimationState>;
		protected var _animFinishedSignal:Signal;
		protected var _isPlaying:Boolean = false;
		protected var _animations:Vector.<Class>;
		protected var _currentSequence:SkeletonAnimationState;
		protected var _cloneClass:Class;
		protected var _crossFadeAnimationId:String;
		protected var _stateTransition:CrossfadeStateTransition = new CrossfadeStateTransition(0.5);
		protected var _currentParsedAnim:String;
		
		protected var _interactMesh:Mesh;
		protected var _interactionJoint:int;
		protected var _animationSet:SkeletonAnimationSet;
		protected var _posture:String;
		protected var _animationVO:AnimationVO;
		protected var _reversedAnims:Vector.<String> = new Vector.<String>();
		
		private var _isWaiting:Boolean = false;
		private var _onFinishedListener:Function;
		
		
		private var _bugTracker:int;
		
		public function BaseAnimation(clone:Boolean = false) {
			_sequences = new Vector.<SkeletonAnimationState>();
			_currentSequences = new Vector.<SkeletonAnimationState>();
			_animFinishedSignal = new Signal();
			if (clone) {
				return;
			}
			init();
		}
		
		protected function init():void {
			nextAnimation();
		}
		
		private function onAnimationComplete(e:AssetEvent):void {
			initSequence(e.asset as SkeletonAnimationState);
			
			if (_isWaiting) {
				_isWaiting = false;
				play();
			}
			
			if (_animations.length > 0) {
				nextAnimation();
			}else {
				_onFinishedListener && _onFinishedListener(null);
			}
		}
		
		public function initAnimator(animator:SkeletonAnimator, animationSet:SkeletonAnimationSet, baseAnimator:BaseAnimator):void {
			_animationSet = animationSet;
			_baseAnimator = baseAnimator;
			_animator = animator;
			for each(var seq:SkeletonAnimationState in _sequences) {
				if (_animationSet.hasState(seq.stateName)) {
					//_animator.removeSequence(seq.name);
				}
				_animationSet.addState(seq.stateName, seq);
			}
		}
		
		/** TODO
		 * crossFadeAnimationId?
		 */
		public function play(animationVO:AnimationVO = null, crossFadeAnimationId:String = null):void {
			
			_animationVO = animationVO || _animationVO;
			_crossFadeAnimationId = crossFadeAnimationId;
			
			if (!_animator) {
				return;
			}
			
			if (_sequences.length > 0) {
				startAnim();
				return;
			}
			
			_isWaiting = true;
		}
		
		public function stopToIdle():void {
			stopAnimation();
		}
		
		private function onDeactivate(e:AnimatorEvent):void {
			stopAnimation();
		}
		
		public function stopAnimation():void {
			if(_isPlaying){
				_animator.stop();
				_isPlaying = false;
				_currentSequence.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onSequenceDone);
			}
		}
		
		protected function startAnim():void {
			_isPlaying = true;
			setCurrentAnim();
			setSpeed();
			setCrossFadeTime();
			if (!_currentSequence.hasEventListener(AnimationStateEvent.PLAYBACK_COMPLETE)) {
				_currentSequence.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onSequenceDone);
			}
			/* TODO
			 *
			 */
			_animator.play(_currentSequence.stateName, _stateTransition);
		}
		
		protected function setCrossFadeTime():void {
			_stateTransition.blendSpeed = 0.1;
		}
		
		protected function setSpeed():void {
			_animator.playbackSpeed = 1;
		}
		
		protected function setCurrentAnim():void {
			if (!_sequences) {
				trace("######### yes, again the anim bug");
				return;
			}
			var currentAnim:int = Math.random() * _sequences.length;
			_currentSequence = _sequences[currentAnim];
		}
		
		protected function onSequenceDone(e:AnimationStateEvent):void {
			_currentSequence.removeEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onSequenceDone);
			if (_animationVO.isLooping) {
				startAnim();
			}else {
				_animFinishedSignal.dispatch();
			}
		}
		
		public function clone(animVO:AnimationVO):BaseAnimation {
			var anim:BaseAnimation = new _cloneClass(true);
			for each(var seq:SkeletonAnimationState in _sequences) {
				anim._sequences.push(seq.clone());
			}
			
			return anim;
		}
		
		/* INTERFACE maryfisher.framework.view.IViewComponent */
		
		override public function get componentType():String {
			return "";
		}
		
		override public function destroy():void {
			stopAnimation();
			_animFinishedSignal.removeAll();
			_animFinishedSignal = null;
			_sequences.length = 0;
			_bugTracker = 3000;
			_sequences = null;
		}
		
		override public function addOnFinished(listener:Function):void {
			if (!_animations || _animations.length == 0) {
				listener(null);
				return;
			}
			_onFinishedListener = listener;
		}
		
		private function nextAnimation():void {
			var p:Class = _animations.pop();
			_currentParsedAnim = getQualifiedClassName(p).replace(getQualifiedClassName(this) + "_", "");
			var assetLoader:AssetLoader = new AssetLoader();
			var token:AssetLoaderToken = assetLoader.loadData(new p(), "", null, null, new MD5AnimParser());
			token.addEventListener(AssetEvent.ANIMATION_STATE_COMPLETE, onAnimationComplete);
		}
		
		protected function initSequence(anim:SkeletonAnimationState):void {
			anim.stateName = _currentParsedAnim;
			anim.name = _currentParsedAnim;
			anim.looping = false;
			_sequences.push(anim);
			
			/** TODO
			 * 
			 */
			//if (_reversedAnims.indexOf(_currentParsedAnim) != -1) {
				//var cl:SkeletonAnimationState = anim.clone();
				//cl.reverse();
				//cl.name = anim.name + "_reversed";
				//_sequences.push(cl);
			//}
		}
		
		public function interactWith(mesh:Mesh, animationState:SkeletonAnimationSet):void {
			_animationSet = animationState;
			_interactMesh = mesh;
			//offset
		}
		
		protected function startInteraction():void {			
			new ViewCommand(this, ViewCommand.REGISTER_VIEW);
		}
		
		protected function stopInteraction():void {
			new ViewCommand(this, ViewCommand.UNREGISTER_VIEW);
			_interactMesh = null;
		}
		
		/* INTERFACE maryfisher.framework.view.ITickedObject */
		
		public function nextTick(interval:int):void {
			//offset
			_interactMesh.transform =
				_animator.globalPose.jointPoses[_interactionJoint].toMatrix3D();
		}
		
		public function get id():String {
			return "";
		}
		
		public function get animFinishedSignal():Signal {
			return _animFinishedSignal;
		}
	}

}