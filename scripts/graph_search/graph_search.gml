/*

// example #1
	test_search = new graph_search(global.my_graph, "A", "C");
	test_search.pass(); // will serach everything, as _max_passes = infinity

// example #2
	test_search = new graph_search(global.my_graph, "A", "C", 1);

	// step event
	var _s = test_search.pass();
	if (_s) {
		show_debug_message(_s.result());
	}

*/


/// @param {Struct.sd_graph} _graph
/// @param {String} _start
/// @param {String} _end
/// @param {Real} _max_passes
function graph_search(_graph, _start, _end, _max_passes = infinity) constructor {
	finished = false;
	time_taken = 0;
	
	keys = struct_get_names(_graph.vertices);
	dist = {};
	prev = {};
	nodes = [];
	smallest = undefined;
	where = _graph;
	where_start = _start;
	where_end = _end;
	
	path = [];
	distance = [];
	
	for (var i = 0, n = array_length(keys); i < n; i++) {
		if (keys[i] == where_start) {
			// it's this node, so distance to it is 0 :)
			dist[$ keys[i]] = 0;
		} else {
			dist[$ keys[i]] = infinity;
		}
		
		self.priority_add(keys[i], dist[$ keys[i]]);
		prev[$ keys[i]] = undefined;
	}
	
	nodes_visited_in_current_pass = 0;
	nodes_visit_limit = max(_max_passes, 1);
	
	graph_debug($"new search from {where_start} to {where_end}...");
	
	static priority_add = function(key, priority) {
		var index = 0;
		
		for(var i = 0, n = array_length(nodes); i < n; i++) {
			if (nodes[i].priority < priority) {
				index = i;
				break;
			}
		}
		
		array_insert(nodes, index, {key, priority});
		
		return index;
	}
	
	static priority_min = function(_delete = false) {
		var low = infinity;
		var index = undefined;
		for(var i = 0, n = array_length(nodes); i < n; i++) {
			if (nodes[i].priority < low) {
				low = nodes[i].priority;
				index = i;
			}
		}
		
		var val = undefined;
		if (index != undefined) {
			val = nodes[index].key;
			if (_delete) {
				array_delete(nodes, index, 1);
			}
		}
		
		return val;
	}
	
	static priority_delete_min = function() {
		return self.priority_min(true);
	}
	
	/// @desc Searches
	static pass = function() {
		
		if (finished) return true;
		
		nodes_visited_in_current_pass = 0;
		
		var _time = get_timer();
		while (array_length(nodes)) {
			
			smallest = self.priority_min();
			
			if (smallest == where_end) {
				finished = true;
				
				// now prepare results
				path = [];
				distance = 0;
				path = [where_start];
				
				while(prev[$ smallest] != undefined) {
					array_insert(path, 1, smallest);
					smallest = prev[$ smallest];
				}
		
				for (var i = 1, n = array_length(path); i < n; i++) {
					distance += where.vertices[$ path[i-1]].connections[$ path[i]];
				}
		
				graph_debug($"finished way with distance {distance} trough {path}.");
				
				break;
				// ends
			}
			
			self.priority_delete_min();
			
			graph_debug($"... traversing {smallest}");
		
			if (smallest == undefined or dist[$ smallest] == infinity) {
				continue;
			}
			
			var _vertex_keys = where.vertices[$ smallest].keys();
			var neighbor = undefined, len = infinity;
			// iterate over all neighbor vertices for this vertice
			graph_debug($"... >> checking distances to connected nodes: {_vertex_keys}");
			for(var i = 0, n = array_length(_vertex_keys); i < n; i++) {
				neighbor = _vertex_keys[i];
				
				len = dist[$ smallest] + where.vertices[$ smallest].connections[$ neighbor];
				
				if(len < dist[$ neighbor]) {
					dist[$ neighbor] = len;
					prev[$ neighbor] = smallest;

					self.priority_add(neighbor, len);
		        }
			}
			
			nodes_visited_in_current_pass++;
			if (nodes_visited_in_current_pass >= nodes_visit_limit) {
				break;
			}
		}
		time_taken += get_timer() - _time;
		
		return finished;
	}
	
	/// @desc Gives result (if exists)
	static result = function() {
		// it uses short syntax for structs, where {a} == {a: a}
		return {
			finished,
			found: array_length(path) > 1,
			time_taken: time_taken / 1000000,
			path,
			distance,
		};
	}
}