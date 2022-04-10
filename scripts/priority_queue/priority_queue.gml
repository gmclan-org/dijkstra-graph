function priority_queue() constructor {
	_nodes = [];

	static enqueue = function (key, priority) {
		array_push(self._nodes, {key: key, priority: priority });
		self.sort();
	}
  
	static dequeue = function () {
		if (!array_length(self._nodes))
			return undefined;
	  
		var _k = self._nodes[0].key;
		for(var i = 0; i < array_length(self._nodes) - 1; i++) {
			_nodes[i] = _nodes[i+1];
		}
		array_pop(_nodes);
		return _k;
	}
  
	static sort = function () {
		array_sort(self._nodes, function (a, b) {
			return a.priority - b.priority;
		});
	}
  
	static is_empty = function () {
		return array_length(self._nodes) == 0;
	}
}