package maryfisher.util.animation {
	import away3d.animators.SmoothSkeletonAnimator;
	import maryfisher.austengames.model.data.party.event.PartyGuestVO;
	import maryfisher.austengames.model.data.view.AnimationVO;
	import maryfisher.framework.view.IViewComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IAnimation extends IViewComponent {
		/** TODO
		 * guestVO
		 */
		//function set guestVO(vo:PartyGuestVO):void;
		//function set instructions(spec:Vector.<String>):void;
		function play(animationVO:AnimationVO = null, crossFadeAnimationId:String = null):void;
		function stopToIdle():void;
		function stopAnimation():void;
		function get id():String;
		function get animFinishedSignal():Signal;
		//function initAnimator(animator:SmoothSkeletonAnimator):void;
	}
	
}