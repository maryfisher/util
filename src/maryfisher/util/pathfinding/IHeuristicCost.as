package maryfisher.util.pathfinding {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface IHeuristicCost {
		function calculate(node1:INode, node2:INode):Number;
	}
	
}