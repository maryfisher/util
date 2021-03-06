package maryfisher.util.pathfinding {
	import adobe.utils.CustomActions;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Graph {
		
		public var nodes:Vector.<INode> = new Vector.<INode>();
		public var edges:Vector.<Vector.<Edge>> = new Vector.<Vector.<Edge>>();
		public var allEdges:Dictionary = new Dictionary();
		
		public function Graph() { }
		
		public function addNode(node:INode, connections:Array, costs:Array = null):void {
			//node.index = nodes.length;
			//nodes.push(node);
			if (node.index >= nodes.length) {
				nodes.length = node.index;
			}
			nodes[node.index] = node;
			
			addConnections(node, connections, costs);
		}
		
		public function addConnections(node:INode, connections:Array, costs:Array = null):void {
			var toEdges:Vector.<Edge> = new Vector.<Edge>();
			var index:int;
			for each(var c:int in connections) {
				//trace("addNode", node.index, "with connection to", c);// , "and cost:", costs && costs[c])
				
				if(!allEdges[c + "," + node.index]){
					var toEdge:Edge = new Edge(c, node.index, costs ? costs[index] : 1);
					toEdges.push(toEdge);
					allEdges[c + "," + node.index] = toEdge;
				}
				//fromEdges
				var fromEdge:Edge
				if(!allEdges[node.index + "," + c]){
					fromEdge = new Edge(node.index, c, costs ? costs[index] : 1);
					allEdges[node.index + "," + c] = fromEdge;
				}else {
					fromEdge = null;
				}
				if (c >= edges.length) {
					edges.length = c + 1;
					edges[c] = new Vector.<Edge>();
				}
				if (!edges[c]) {
					edges[c] = new Vector.<Edge>();
				}
				fromEdge && (edges[c].push(fromEdge));
				index++;
			}
			if (node.index >= edges.length) {
				edges.length = node.index + 1;
			}
			if (edges[node.index]) {
				edges[node.index] = edges[node.index].concat(toEdges);
			}else{
				edges[node.index] = toEdges;
			}
			//edges.push(toEdges);
		}
		
		//public function addConnections(node:INode, connections:Array, costs:Array = null):void {
			//var toEdges:Vector.<Edge> = edges[node.index] || new Vector.<Edge>();
			//if (!edges[node.index]) edges[node.index] = toEdges;
			//for each(var c:int in connections) {
				//var toEdge:Edge;
				//var found:Boolean = false;
				//for (var i:int = 0; i < toEdges.length; i++) {
					//toEdge = toEdges[i];
					//if (toEdge.toNode == c) {
						//found = true;
						//break;
					//}
				//}
				//if (!found) {
					//toEdges.push(new Edge(c, node.index, costs ? costs[c] : 1));
				//}
				//
				//var fromEdges:Vector.<Edge> = edges[c] || new Vector.<Edge>();
				//if (!edges[c]) edges[c] = fromEdges;
				//var fromEdge:Edge;
				//found = false;
				//for (i = 0; i < fromEdges.length; i++) {
					//fromEdge = fromEdges[i];
					//if (fromEdge.fromNode == node.index) {
						//found = true;
						//break;
					//}
				//}
				//if (!found) {
					//fromEdges.push(new Edge(node.index, c, costs ? costs[c] : 1));
				//}
				//
			//}
			//
		//}
	}

}