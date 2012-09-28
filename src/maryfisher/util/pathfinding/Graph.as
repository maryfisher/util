package maryfisher.util.pathfinding {
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Graph {
		
		public var nodes:Vector.<INode> = Vector.<INode>([null]);
		public var edges:Vector.<Vector.<Edge>> = new Vector.<Vector.<Edge>>();
		
		//private var shortestPath:Vector.<Edge>;
		//private var costToThisNode:Vector.<int>;
		//private var searchFrontier:Vector.<Edge>;
		
		public function Graph() { }
		
		public function addNode(node:INode, connections:Array, costs:Array = null):void {
			//var node:Node = new Node(nodes.length, nodeId);
			node.index = nodes.length;
			nodes.push(node);
			var toEdges:Vector.<Edge> = new Vector.<Edge>();
			for each(var c:int in connections) {
				//trace("addNode", node.index, "with connection to", c);// , "and cost:", costs && costs[c])
				var toEdge:Edge = new Edge(c, node.index, costs ? costs[c] : 1);
				toEdges.push(toEdge);
				var fromEdge:Edge = new Edge(node.index, c, costs ? costs[c] : 1);
				if (c >= edges.length) {
					edges.length = c + 1;
					//fromEdges
					edges[c] = new Vector.<Edge>();
				}
				edges[c].push(fromEdge);
			}
			edges.push(toEdges);
		}
		
		//public function addNode(nodeId:String, connections:Array, costs:Array = null):Node {
			//
			//var node:Node = new Node(nodes.length, nodeId);
			//nodes.push(node);
			//var toEdges:Vector.<Edge> = new Vector.<Edge>();
			//for each(var c:int in connections) {
				//trace("addNode", nodeId, node.index, "with connection to", c, nodes[c].id);// , "and cost:", costs && costs[c])
				//var toEdge:Edge = new Edge(c, node.index, costs ? costs[c] : 1);
				//toEdges.push(toEdge);
				//var fromEdge:Edge = new Edge(node.index, c, costs ? costs[c] : 1);
				//if (c >= _edges.length) {
					//_edges.length = c + 1;
					//fromEdges
					//_edges[c] = new Vector.<Edge>();
				//}
				//_edges[c].push(fromEdge);
			//}
			//_edges.push(toEdges);
			//
			//return node;
		//}
		
		//public function search(source:int, target:int):Vector.<int> {
		//public function search(source:int, condition:IGraphTargetCondition):Vector.<int> {
			//
			//var searchFrontier:Vector.<Edge> = new Vector.<Edge>(nodes.length);
			//var costToThisNode:Vector.<int> = new Vector.<int>(nodes.length)
			//var shortestPath:Vector.<Edge> = new Vector.<Edge>(nodes.length);
			//
			//var priorityQueue:Vector.<WeightedNode> = new Vector.<WeightedNode>();
			//priorityQueue.push(new WeightedNode(source, 0));
			//
			//while (priorityQueue.length > 0) {
				//var nextClosestNode:int = getLowestCostNode(priorityQueue);
				//
				//if (searchFrontier[nextClosestNode]) {
					//shortestPath[nextClosestNode] = searchFrontier[nextClosestNode];
				//}else {
					//searchFrontier[nextClosestNode] = new Edge(2,2);
				//}
				//
				//Condition
				//if (nextClosestNode == target) {
				//if (condition.isTarget(nodes[nextClosestNode])) {
					//var finishedPath:Vector.<int> = Vector.<int>([target]);
					//var finishedPath:Vector.<int> = Vector.<int>([nextClosestNode]);
					//trace("to", nextClosestNode)
					//var e:Edge = shortestPath[target];
					//var e:Edge = shortestPath[nextClosestNode];
					//finishedPath.push(e.fromNode);
					//trace("from", e.fromNode);
					//while (e = shortestPath[e.fromNode]) {
						//finishedPath.push(e.fromNode);
						//trace("from", e.fromNode);
					//}
					//return finishedPath;
				//}
				//
				//var nextEdges:Vector.<Edge> = edges[nextClosestNode];
				//
				//for each(var nextEdge:Edge in nextEdges ) {
					//if (nodes[nextEdge.toNode].isTaken) continue;
					//
					//var newCost:int = costToThisNode[nextClosestNode] + nextEdge.cost;
					//
					//if (searchFrontier[nextEdge.toNode] == null) {
						//costToThisNode[nextEdge.toNode] = newCost;
						//muss hier die alte Node rausgenommen werden?
						//priorityQueue.push(new WeightedNode(nextEdge.toNode, newCost));
						//searchFrontier[nextEdge.toNode] = nextEdge;
					//}else if (newCost < costToThisNode[nextEdge.toNode]
						//&& shortestPath[nextEdge.toNode] == null) {
						//
						//costToThisNode[nextEdge.toNode] = newCost;
						//priorityQueue[nextEdge.toNode].cost = newCost;
						//searchFrontier[nextEdge.toNode] = nextEdge;
					//}
				//}
			//}
			//
			//return null;
		//}
		
		private function getLowestCostNode(priorityQueue:Vector.<WeightedNode>):int {
			var sn:int;
			var cost:int = 1000;
			var deleteNode:WeightedNode;
			for each(var wn:WeightedNode in priorityQueue) {
				if (wn && wn.cost < cost) {
					cost = wn.cost;
					sn = wn.index;
					deleteNode = wn;
				}
			}
			priorityQueue.splice(priorityQueue.indexOf(deleteNode), 1);
			return sn;
		}
	}

}