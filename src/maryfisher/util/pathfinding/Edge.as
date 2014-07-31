package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Edge {
		
		public var fromNode:int;
		public var toNode:int;
		//public var cost:Number = 0;
		public var cost:Number;
		
		//public function Edge(to:int, from:int, cost:Number = 0) {
		public function Edge(to:int, from:int, cost:Number = 1) {
			this.cost = cost;
			fromNode = from;
			toNode = to;
		}
		public function toString():String {
			return "[Edge fromNode=" + fromNode + " toNode=" + toNode + " cost=" + cost + "]";
		}
	}

}