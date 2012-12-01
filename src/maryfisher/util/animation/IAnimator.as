package maryfisher.util.animation {
	import maryfisher.austengames.model.data.view.AnimationVO;
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IAnimator {
		function playAnimation(animVO:AnimationVO, listener:Function = null):void;
		function stopAnimation(anim:String, stopToIdle:Boolean = false):void;
		//function set instructions(value:Vector.<String>):void
	}
	
}