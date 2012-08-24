package maryfisher.austengames.util {
	/**
	 * ...
	 * @author mary_fisher
	 */
	public class Path implements IHeuristicCost, IGraphTargetCondition{
		
		public var target:INode;
		public var graph:Graph;
		public var condition:IGraphTargetCondition;
		public var heuristic:IHeuristicCost;
		
		private var _searchFrontier:Vector.<Edge>;
		private var _costToThisNode:Vector.<int>;
		private var _heuristicCostToThisNode:Vector.<int>;
		private var _shortestPath:Vector.<Edge>;
		private var _priorityQueue:Vector.<WeightedNode>;
		
		public function Path(graph:Graph) {
			this.graph = graph;
			condition = this;
			heuristic = this;
			
			var l:int = graph.nodes.length;
			_searchFrontier = new Vector.<Edge>(l);
			_costToThisNode = new Vector.<int>(l)
			_heuristicCostToThisNode = new Vector.<int>(l)
			_shortestPath = new Vector.<Edge>(l);
			_priorityQueue = new Vector.<WeightedNode>();
		}
		
		/* TODO
		 * depth
		 */
		public function searchFor(source:int, depth:int = int.MAX_VALUE):Vector.<int> {
			var l:int = graph.nodes.length;
			_searchFrontier.length = 0;
			_searchFrontier.length = l;
			_costToThisNode.length = 0;
			_costToThisNode.length = l;
			//_heuristicCostToThisNode.length = 0;
			_shortestPath.length = 0;
			_shortestPath.length = l;
			_priorityQueue.length = 0;
			_priorityQueue.length = l;
			
			var depthCounter:int;
			
			//_priorityQueue.push(new WeightedNode(source, 0, 0));
			_priorityQueue[source] = (new WeightedNode(source, 0, 0));
			
			while (_priorityQueue.length > 0) {
				
				var nextClosestNodeId:int = getLowestCostNode();
				if (_searchFrontier[nextClosestNodeId]) {
					_shortestPath[nextClosestNodeId] = _searchFrontier[nextClosestNodeId];
				}else {
					/** TODO
					 * problematisch
					 */
					_searchFrontier[nextClosestNodeId] = new Edge(2,2);
				}
				
				var nextClosestNode:INode = graph.nodes[nextClosestNodeId];
				//if (depthCounter > depth || (nextClosestNode.isTraversable && condition.isTarget(nextClosestNode))) {
				if (depthCounter > depth || (nextClosestNode.isReachable && condition.isTarget(nextClosestNode))) {
					return buildPath(nextClosestNodeId, source);
				}
				
				var nextEdges:Vector.<Edge> = graph.edges[nextClosestNodeId];
				
				for each(var nextEdge:Edge in nextEdges ) {
					var toNode:INode = graph.nodes[nextEdge.toNode];
					if (!toNode.isTraversable && !condition.isTarget(toNode)) {
						//trace("not traversable", toNode.index, "from", nextClosestNode, "because node is traversable", toNode.isTraversable);
						continue;
					}
					
					var newCost:int = _costToThisNode[nextClosestNodeId] + nextEdge.cost;
					//var heuristicCost:int = heuristic.calculate(toNode, target ? target : graph.nodes[nextClosestNodeId]) + newCost;
					var heuristicCost:int = heuristic.calculate(toNode, target) + newCost;
					
					if (_searchFrontier[nextEdge.toNode] == null) {
						_costToThisNode[nextEdge.toNode] = newCost;
						//_heuristicCostToThisNode[nextEdge.toNode] = newCost + heuristicCost;
						
						//muss hier die alte Node rausgenommen werden?
						//_priorityQueue.push(new WeightedNode(nextEdge.toNode, newCost, heuristicCost));
						//trace("added new priority", nextEdge.toNode);
						_priorityQueue[nextEdge.toNode] = (new WeightedNode(nextEdge.toNode, newCost, heuristicCost));
						_searchFrontier[nextEdge.toNode] = nextEdge;
					}else if (newCost < _costToThisNode[nextEdge.toNode]
						&& _shortestPath[nextEdge.toNode] == null) {
						
						_costToThisNode[nextEdge.toNode] = newCost;
						//_heuristicCostToThisNode[nextEdge.toNode] = newCost + heuristicCost;
						_priorityQueue[nextEdge.toNode].cost = newCost;
						_priorityQueue[nextEdge.toNode].heuristicCost = heuristicCost;
						_searchFrontier[nextEdge.toNode] = nextEdge;
					}
				}
				
				depthCounter++;
			}
			
			return null;
		}
		
		/* INTERFACE maryfisher.austengames.util.IHeuristicCost */
		
		public function calculate(node1:INode, node2:INode):int {
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
		
		private function getLowestCostNode():int {
			var sn:int;
			var cost:int = 10000000;
			//var deleteIndex:int = 0;
			var wn:WeightedNode;
			//for each(var wn:WeightedNode in _priorityQueue) {
			var l:int = _priorityQueue.length;
			for (var i:int = 0; i < l; i++ ) {
				wn = _priorityQueue[i];
				//if(wn) trace("weighted nodes", wn);
				if (wn && wn.heuristicCost < cost) {
					cost = wn.heuristicCost;
					sn = wn.index;
					//deleteIndex = i;
				}
			}
			//if (sn == 0) trace(_priorityQueue);
			//trace("before splice", priorityQueue);
			//_priorityQueue.splice(deleteIndex, 1);
			_priorityQueue[sn] = null;
			//trace("after splice", priorityQueue)
			return sn;
		}
		
		private function buildPath(nextClosestNode:int, source:int):Vector.<int> {
			var finishedPath:Vector.<int> = Vector.<int>([nextClosestNode]);
			trace("to", nextClosestNode)
			var e:Edge = _shortestPath[nextClosestNode];
			if (e.fromNode != source) {
				finishedPath.push(e.fromNode);
				trace("from", e.fromNode);
			}
			while (e = _shortestPath[e.fromNode]) {
				if(e.fromNode != source) finishedPath.push(e.fromNode);
				trace("from", e.fromNode);
			}
			return finishedPath;
		}
		
	}

}