package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class WeightedNode {
		public var index:int;
		public var cost:int;
		public var heuristicCost:int;
		public var parentNode:WeightedNode;
		
		public function WeightedNode(index:int, cost:int, heuristicCost:int, parentNode:WeightedNode = null) {
			this.parentNode = parentNode;
			this.index = index;
			this.heuristicCost = heuristicCost;
			this.cost = cost;
		}
		public function toString():String {
			return "[WeightedNode cost=" + cost + ", index=" + index + "]";
		}
	}

}