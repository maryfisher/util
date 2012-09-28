package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class DiagonalHeuristic implements IHeuristicCost {
		
		public function DiagonalHeuristic() {
			
		}
		
		/* INTERFACE maryfisher.austengames.util.IHeuristicCost */
		
		public function calculate(node1:INode, node2:INode):int {
			var dx:Number = Math.abs(node1.x - node2.x);
			var dy:Number = Math.abs(node1.y - node2.y);
			var diag:Number = Math.min( dx, dy );
			return diag * 2 + (dx + dy - 2 * diag);
		}
		
	}

}