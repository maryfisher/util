package maryfisher.util.pathfinding {
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class BaseNode implements INode {
		private var _isTraversable:Boolean = true;
		private var _index:int;
		public var position:Vector3D;
		public var gridPosition:Vector3D;
		
		public function BaseNode(index:int) {
			_index = index;
		}
		
		/* INTERFACE maryfisher.util.pathfinding.INode */
		
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			_index = value;
		}
		
		public function get x():int {
			return position.x;
		}
		
		public function get y():int {
			return position.z;
		}
		
		public function get isReachable():Boolean {
			return _isTraversable;
		}
		
		public function get isTraversable():Boolean {
			return _isTraversable;
		}
		
	}

}