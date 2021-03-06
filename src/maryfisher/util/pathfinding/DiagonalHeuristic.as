package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DiagonalHeuristic implements IHeuristicCost {
		
		public function DiagonalHeuristic() {
			
		}
		
		/* INTERFACE maryfisher.austengames.util.IHeuristicCost */
		
		public function calculate(node1:INode, node2:INode):Number {
			var dx:Number = Math.abs(node1.x - node2.x);
			var dy:Number = Math.abs(node1.z - node2.z);
			var diag:Number = Math.min( dx, dy );
			return dx + dy;
			//return diag * 2 + (dx + dy - 2 * diag);
		}
		
	}

}