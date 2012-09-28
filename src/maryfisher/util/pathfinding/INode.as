package maryfisher.util.pathfinding {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface INode {
		function get index():int;
		function set index(value:int):void;
		function get x():int;
		function get y():int;
		function get isReachable():Boolean;
		function get isTraversable():Boolean;
	}
	
}