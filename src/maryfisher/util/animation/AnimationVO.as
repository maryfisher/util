package maryfisher.util.animation {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class AnimationVO {
		
		public var animationId:String;
		public var isLooping:Boolean;
		public var instructions:Vector.<String> = new Vector.<String>();
		
		public function AnimationVO(animationId:String, isLooping:Boolean, instructions:String = "") {
			this.animationId = animationId;
			this.isLooping = isLooping;
			this.instructions = Vector.<String>(instructions.split(","));
		}
		
	}

}