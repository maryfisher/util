package maryfisher.util.pathfinding {
	
	/**
	 * ...
	 * @author mary_fisher
	 */
	public interface INode {
		function get index():int;
		//function set index(value:int):void;
		function get x():Number;
		function get y():Number;
		function get z():Number;
		function get isReachable():Boolean;
		function get isTraversable():Boolean;
	}
	
}