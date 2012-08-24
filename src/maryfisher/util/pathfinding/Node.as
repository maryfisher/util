package maryfisher.austengames.util {
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Node {
		
		//nur zu debug Zwecken
		public var id:String;
		public var index:int;
		
		public function Node(index:int, id:String) {
			this.id = id;
			this.index = index;
		}
		
		public function toString():String {
			return "[Node id=" + id + " index=" + index + "]";
		}
		
		public function get isTaken():Boolean {
			return false;
		}
		
		public function set isTarget(value:Boolean):void {
			
		}
	}

}