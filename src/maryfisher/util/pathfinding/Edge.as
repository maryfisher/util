package maryfisher.util.pathfinding {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Edge {
		
		public var fromNode:int;
		public var toNode:int;
		public var cost:int = 1;
		
		public function Edge(to:int, from:int, cost:int = 1) {
			fromNode = from;
			toNode = to;
		}
		public function toString():String {
			return "[Edge fromNode=" + fromNode + " toNode=" + toNode + " cost=" + cost + "]";
		}
	}

}