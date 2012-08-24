package maryfisher.austengames.util {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class TargetGraphCondition implements IGraphTargetCondition {
		private var _target:int;
		
		public function TargetGraphCondition(target:int) {
			_target = target;
			
		}
		
		/* INTERFACE maryfisher.austengames.util.IGraphTargetCondition */
		
		public function isTarget(node:Node):Boolean {
			return node.index == _target;
		}
		
	}

}