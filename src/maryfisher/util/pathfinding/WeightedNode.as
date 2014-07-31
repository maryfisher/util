package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class WeightedNode {
		public var index:int;
		public var cost:Number;
		public var heuristicCost:Number;
		public var parentNode:WeightedNode;
		
		public function WeightedNode(index:int, cost:Number, heuristicCost:Number, parentNode:WeightedNode = null) {
		//public function WeightedNode(index:int, heuristicCost:Number, parentNode:WeightedNode = null) {
			this.parentNode = parentNode;
			this.index = index;
			this.heuristicCost = heuristicCost;
			this.cost = cost;
		}
		//public function toString():String {
			//return "[WeightedNode cost=" + cost + ", index=" + index + ", heuristicCost=" + heuristicCost + "]";
		//}
	}

}