package maryfisher.util.animation {
	import away3d.animators.data.Skeleton;
	import away3d.animators.SkeletonAnimationSet;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.SmoothSkeletonAnimator;
	import away3d.animators.transitions.CrossfadeStateTransition;
	import maryfisher.framework.command.asset.IAssetCallback;
	import maryfisher.framework.command.asset.LoadAssetCommand;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseAnimator implements IAssetCallback, IAnimator{
		
		private var _animator:SkeletonAnimator;
		private var _animationSet:SkeletonAnimationSet;
		private var _skeleton:Skeleton;
		
		private var _currentAnimation:BaseAnimation;
		private var _animationVO:AnimationVO;
		private var _path:String;
		protected var _animFinishedSignal:Signal;
		protected var _posture:String;
		
		public function BaseAnimator(path:String) {
			_path = path;
			_animFinishedSignal = new Signal();
		}
		
		public function setAnimator(animationSet:SkeletonAnimationSet):SkeletonAnimator {
			_animator = new SkeletonAnimator(animationSet, _skeleton);
			_animationSet = animationSet;
			_animator.updateRootPosition = false;
			_currentAnimation && _currentAnimation.initAnimator(_animator, _animationSet, this);
			
			return _animator;
		}
		
		public function get posture():String {
			return _posture;
		}
		
		public function set posture(value:String):void {
			_posture = value;
		}
		
		public function set skeleton(value:Skeleton):void {
			_skeleton = value;
		}
		
		public function playAnimation(animationVO:AnimationVO, listener:Function = null):void {
			_animationVO = animationVO;
			_animFinishedSignal.removeAll();
			listener && _animFinishedSignal.addOnce(listener);
			if (_currentAnimation && _currentAnimation.id == animationVO.animationId) {
				_currentAnimation.play(animationVO, null);
				return;
			}
			
			/** TODO
			 * verschieben, so dass es Übergang gibt
			 */
			_currentAnimation && _currentAnimation.destroy();
			
			new LoadAssetCommand(_path, this, _animationVO.animationId);
		}
		
		public function assetFinished(cmd:BaseAssetCommand):void {
			
			if (cmd.id == _path) {
				var anim:BaseAnimation = cmd.viewComponent as BaseAnimation;
				if (anim.id != _animationVO.animationId) {
					return;
				}
				
				var oldId:String = _currentAnimation ? _currentAnimation.id : null;
				_currentAnimation = anim.clone(_animationVO);
				_currentAnimation.initAnimator(_animator, _animationSet, this);
				_currentAnimation.animFinishedSignal.add(onAnimationFinished);
				_currentAnimation.play(_animationVO, oldId);
			}
		}
		
		private function onAnimationFinished():void {
			_animFinishedSignal.dispatch();
		}
		
		public function stopAnimation(anim:String, stopToIdle:Boolean = false):void {
			if(_currentAnimation && _currentAnimation.id == anim) {
				if (!stopToIdle) {
					_currentAnimation.stopAnimation();
				}else {
					_currentAnimation.stopToIdle();
				}
			}
		}
	}

}