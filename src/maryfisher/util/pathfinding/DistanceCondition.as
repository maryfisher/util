package maryfisher.util.pathfinding {
	import maryfisher.austengames.model.data.party.event.PartyPathNodeVO;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DistanceCondition implements IGraphTargetCondition {
		
		private var _distance:int;
		private var _startNode:INode;
		
		public function DistanceCondition(startNode:INode, distance:int) {
			_startNode = startNode;
			_distance = distance;
			
		}
		
		/* INTERFACE maryfisher.austengames.util.IGraphTargetCondition */
		
		public function isTarget(node:INode):Boolean {
			var dx:Number = Math.abs(node.x - _startNode.x);
			var dy:Number = Math.abs(node.y - _startNode.y);
			var diag:Number = Math.min( dx, dy );
			var dist:int = diag * 2 + (dx + dy - 2 * diag);
			
			return _distance <= dist;
		}
		
	}

}