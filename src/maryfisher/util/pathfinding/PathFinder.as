package maryfisher.util.pathfinding {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class PathFinder implements IHeuristicCost, IGraphTargetCondition{
		
		public var target:INode;
		public var graph:Graph;
		public var condition:IGraphTargetCondition;
		public var heuristic:IHeuristicCost;
		
		private var _searchFrontier:Vector.<Edge>;
		private var _costToThisNode:Vector.<Number>;
		private var _heuristicCostToThisNode:Vector.<int>;
		private var _shortestPath:Vector.<Edge>;
		//private var _priorityQueue2:Vector.<WeightedNode>;
		private var _priorityQueue:Dictionary;
		
		private var _openQueue:Array;
		private var _priorityLength:int;
		
		public function PathFinder(graph:Graph) {
			this.graph = graph;
			condition = this;
			heuristic = this;
			
			var l:int = graph.nodes.length;
			_searchFrontier = new Vector.<Edge>(l);
			_costToThisNode = new Vector.<Number>(l)
			_heuristicCostToThisNode = new Vector.<int>(l)
			_shortestPath = new Vector.<Edge>(l);
			//_priorityQueue = new Vector.<WeightedNode>();
			
			_openQueue = [];
		}
		
		public function pathFrom(source:int, depth:int = int.MAX_VALUE):Vector.<int> {
			var l:int = graph.nodes.length;
			
			//_priorityQueue2.length = 0;
			_priorityQueue = new Dictionary();
			_priorityLength = 0;
			
			var depthCounter:int;
			
			//_priorityQueue[source] = new WeightedNode(source, 0);
			_priorityQueue[source] = new WeightedNode(source, 0, 0);
			_priorityLength++;
			
			while (_priorityLength > 0) {
			//while (_priorityQueue2.length > 0) {
				
				var nextNode:WeightedNode = getLowestCostNode();
				//var nextClosestNodeId:int = testNode.index;
				var nextClosestNodeId:int = nextNode.index;
				
				var nextClosestNode:INode = graph.nodes[nextClosestNodeId];
				if (depthCounter > depth || (nextClosestNode.isReachable && condition.isTarget(nextClosestNode))) {
					return buildBetterPath(nextNode, source);
				}
				
				var nextEdges:Vector.<Edge> = graph.edges[nextClosestNodeId];
				
				for each(var nextEdge:Edge in nextEdges ) {
					var toNode:INode = graph.nodes[nextEdge.toNode];
					if (!toNode.isTraversable && !condition.isTarget(toNode)) {
						continue;
					}
					var testNode:WeightedNode = _priorityQueue[nextEdge.toNode];
					var costToNode:int = (testNode ? testNode.cost : 0);
					var newCost:int = costToNode + nextEdge.cost;
					var heuristicCost:int = heuristic.calculate(toNode, target) + newCost;
					
					if (testNode == null) {
						trace("testNode == null", nextEdge.toNode)
						_priorityQueue[nextEdge.toNode] = new WeightedNode(nextEdge.toNode, newCost, heuristicCost, nextNode);
						//_priorityQueue[nextEdge.toNode] = new WeightedNode(nextEdge.toNode, heuristicCost, nextNode);
						//_priorityQueue.push(new WeightedNode(nextEdge.toNode, newCost, heuristicCost, nextNode));
					}else if (newCost < costToNode) {
						trace("testNode != null");
						testNode.cost = newCost;
						testNode.heuristicCost = heuristicCost;
						testNode.parentNode = nextNode;
						
					}
				}
				
				depthCounter++;
			}
			
			return null;
		}
		
		public function searchFor(source:int, depth:int = int.MAX_VALUE):Vector.<int> {
			var l:int = graph.nodes.length;
			_searchFrontier.length = 0;
			_searchFrontier.length = l;
			_costToThisNode.length = 0;
			_costToThisNode.length = l;
			//_heuristicCostToThisNode.length = 0;
			_shortestPath.length = 0;
			_shortestPath.length = l;
			_priorityQueue = new Dictionary();
			_priorityLength = 0;
			//_priorityQueue.length = 0;
			//_priorityQueue.length = l;
			
			var beforeTime:int;
			var afterTime:int;
			var depthCounter:int;
			
			//_priorityQueue[source] = (new WeightedNode(source, 0));
			_priorityQueue[source] = (new WeightedNode(source, 0, 0));
			_priorityLength++;
			
			//while (_priorityQueue.length > 0) {
			while (_priorityLength > 0) {
				//beforeTime = getTimer();
				var nextClosestNodeId:int = getLowestCostNode().index;
				//afterTime = getTimer();
				//trace("getLowestCostNode", afterTime - beforeTime);
				//trace("nextClosestNodeId", nextClosestNodeId);
				if (_searchFrontier[nextClosestNodeId]) {
					_shortestPath[nextClosestNodeId] = _searchFrontier[nextClosestNodeId];
				}else {
					/** TODO
					 * problematisch
					 */
					_searchFrontier[nextClosestNodeId] = new Edge(2,2);
				}
				
				var nextClosestNode:INode = graph.nodes[nextClosestNodeId];
				if (depthCounter > depth || (nextClosestNode.isReachable && condition.isTarget(nextClosestNode))) {
					return buildPath(nextClosestNodeId, source);
				}
				
				var nextEdges:Vector.<Edge> = graph.edges[nextClosestNodeId];
				//beforeTime = getTimer();
				for each(var nextEdge:Edge in nextEdges ) {
					var toNodeId:int = nextEdge.toNode;
					var toNode:INode = graph.nodes[toNodeId];
					if (!toNode.isTraversable && !condition.isTarget(toNode)) {
						continue;
					}
					
					var newCost:Number = _costToThisNode[nextClosestNodeId] + nextEdge.cost;
					var heuristicCost:Number = heuristic.calculate(toNode, target) + newCost;
					
					if (_searchFrontier[toNodeId] == null) {
						_costToThisNode[toNodeId] = newCost;
						_priorityQueue[toNodeId] = new WeightedNode(toNodeId, newCost, heuristicCost);
						_searchFrontier[toNodeId] = nextEdge;
					}else if (newCost < _costToThisNode[toNodeId] && _shortestPath[toNodeId] == null) {
						_costToThisNode[toNodeId] = newCost;
						_priorityQueue[toNodeId].cost = newCost;
						_priorityQueue[toNodeId].heuristicCost = heuristicCost;
						_searchFrontier[toNodeId] = nextEdge;
					}
				}
				//afterTime = getTimer();
				//trace("nextEdges", afterTime - beforeTime);
				
				depthCounter++;
			}
			
			return null;
		}
		
		/* INTERFACE maryfisher.austengames.util.IHeuristicCost */
		
		public function calculate(node1:INode, node2:INode):Number {
			return 0;
		}
		
		/* INTERFACE maryfisher.austengames.util.IGraphTargetCondition */
		
		public function isTarget(node:INode):Boolean {
			return node.index == target.index;
		}
		
		//public function search(graph:Graph, source:int, target:int):Vector.<int> {
			//trace("source", source, "target", target)
			//searchFrontier = new Vector.<Edge>(graph.nodes.length);
			//costToThisNode = new Vector.<int>(graph.nodes.length)
			//shortestPath = new Vector.<Edge>(graph.nodes.length);
			//
			//var priorityQueue:Vector.<WeightedNode> = new Vector.<WeightedNode>();
			//priorityQueue.push(new WeightedNode(source, 0));
			//
			//while (priorityQueue.length > 0) {
				//trace("-----------------------------");
				//var nextClosestNode:int = getLowestCostNode(priorityQueue);
				//trace("nextClosestNode", nextClosestNode)
				//if (searchFrontier[nextClosestNode]) {
					//shortestPath[nextClosestNode] = searchFrontier[nextClosestNode];
				//}else {
					//searchFrontier[nextClosestNode] = new Edge(2,2);
				//}
				//
				//if (nextClosestNode == target) {
					//var finishedPath:Vector.<int> = Vector.<int>([target]);
					//trace("shortest Path", shortestPath);
					//trace("to", target)
					//var e:Edge = shortestPath[target];
					//finishedPath.push(e.fromNode);
					//trace("from", e.fromNode);
					//while (e = shortestPath[e.fromNode]) {
						//e = shortestPath[e.fromNode];
						//finishedPath.push(e.fromNode);
						//trace("from", e.fromNode);
					//}
					//return finishedPath;
				//}
				//
				//var nextEdges:Vector.<Edge> = graph.edges[nextClosestNode];
				//trace("nextEdges", nextEdges);
				//for each(var nextEdge:Edge in nextEdges ) {
					//var newCost:int = costToThisNode[nextClosestNode] + nextEdge.cost;
					//
					//if (searchFrontier[nextEdge.toNode] == null) {
						//trace("not yet encountered node", nextEdge.toNode)
						//costToThisNode[nextEdge.toNode] = newCost;
						//muss hier die alte Node rausgenommen werden?
						//priorityQueue.push(new WeightedNode(nextEdge.toNode, newCost));
						//searchFrontier[nextEdge.toNode] = nextEdge;
					//}else if (newCost < costToThisNode[nextEdge.toNode]
						//&& shortestPath[nextEdge.toNode] == null) {
						//trace("encountered node")
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
		
		private function getLowestCostNode():WeightedNode {
			var sn:WeightedNode;
			var cost:Number = 10000000;
			//var wn:WeightedNode;
			//var l:int = _priorityQueue.length;
			//trace("getLowestCostNode l", l);
			//for (var i:int = 0; i < l; i++ ) {
			for each (var wn:WeightedNode in _priorityQueue) {
				//wn = _priorityQueue[i];
				//if (wn && wn.heuristicCost < cost) {
				//trace("cost", wn.heuristicCost, cost);
				if (wn.heuristicCost < cost) {
					cost = wn.heuristicCost;
					sn = wn;
				}
			}
			//trace("delete ", sn.index)
			delete _priorityQueue[sn.index];
			//_priorityQueue[sn.index] = null;
			return sn;
		}
		
		private function buildBetterPath(node:WeightedNode, source:int):Vector.<int> {
			var finishedPath:Vector.<int> = Vector.<int>([node.index]);
			//trace("to", node.index)
			var e:WeightedNode = node.parentNode;
			if (e.index != source) {
				finishedPath.push(e.index);
				//trace("from", e.index);
			}
			while (e = node.parentNode) {
				if(e.index != source) finishedPath.push(e.index);
				//trace("from", e.index);
			}
			return finishedPath;
		}
		
		//private function buildPath(nextClosestNode:int, source:int):Vector.<int> {
		private function buildPath(nextClosestNode:int, source:int):Vector.<int> {
			var finishedPath:Vector.<int> = Vector.<int>([nextClosestNode]);
			//trace("to", nextClosestNode)
			var e:Edge = _shortestPath[nextClosestNode];
			if (e.fromNode != source) {
				finishedPath.push(e.fromNode);
				//trace("from", e.fromNode);
			}
			while (e = _shortestPath[e.fromNode]) {
				if(e.fromNode != source) finishedPath.push(e.fromNode);
				//trace("from", e.fromNode);
			}
			return finishedPath;
		}
		
	}

}