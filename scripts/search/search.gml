/*

// example #1
	test_search = new search(global.my_graph, "A", "C");
	test_search.pass(); // will serach everything, as _max_passes = infinity

// example #2
	test_search = new search(global.my_graph, "A", "C", 1);

	// step event
	var _s = test_search.pass();
	if (_s) {
		show_debug_message(_s.result());
	}

*/


/// @param {Struct.graph} _graph
/// @param {String} _start
/// @param {String} _end
/// @param {Real} _max_passes
function search(_graph, _start, _end, _max_passes = infinity) constructor {
	found = false;
	
	keys = ds_map_keys_to_array(_graph.vertices);
	dist = ds_map_create();
	prev = ds_map_create();
	nodes = ds_priority_create();
	smallest = undefined;
	where = _graph;
	where_start = _start;
	where_end = _end;
	
	path = [];
	distance = [];
	
	for (var i = 0, n = array_length(keys); i < n; i++) {
		if (keys[i] == where_start) {
			// it's this node, so distance to it is 0 :)
			dist[? keys[i]] = 0;
		} else {
			dist[? keys[i]] = infinity;
		}
		ds_priority_add(nodes, keys[i], dist[? keys[i]]);
		prev[? keys[i]] = undefined;
	}
	
	nodes_visited_in_current_pass = 0;
	nodes_visit_limit = max(_max_passes, 1);
	
	graph_debug($"new search from {where_start} to {where_end}...");
	
	static pass = function() {
		
		if (found) return true;
		
		nodes_visited_in_current_pass = 0;
		
		while (!ds_priority_empty(nodes)) {
			smallest = ds_priority_find_min(nodes);
			if (smallest == where_end) {
				found = true;
				
				// now prepare results
				path = [];
				distance = 0;
				path = [where_start];
				
				while(prev[? smallest] != undefined) {
					array_insert(path, 1, smallest);
					smallest = prev[? smallest];
				}
		
				for (var i = 1, n = array_length(path); i < n; i++) {
					distance += where.vertices[? path[i-1]].connections[$ path[i]];
				}
		
				graph_debug($"Found way with distance {distance} trough {path}.");
		
				// cleanup
				// don't forget about cleanup
				ds_map_destroy(dist);
				ds_map_destroy(prev);
				ds_priority_destroy(nodes);
				
				break;
				// ends
			}
			
			ds_priority_delete_min(nodes);
			
			graph_debug($"... traversing {smallest}");
		
			if (smallest == undefined or dist[? smallest] == infinity) {
				continue;
			}
			
			var _vertex_keys = where.vertices[? smallest].keys;
			var neighbor = undefined, len = infinity;
			// iterate over all neighbor vertices for this vertice
			for(var i = 0, n = array_length(_vertex_keys); i < n; i++) {
				neighbor = _vertex_keys[i];
				graph_debug($"... >> {neighbor}");
				
				len = dist[? smallest] + where.vertices[? smallest].connections[$ neighbor];
				
				if(len < dist[? neighbor]) {
					dist[? neighbor] = len;
					prev[? neighbor] = smallest;

					ds_priority_add(nodes, neighbor, len);
		        }
			}
			
			nodes_visited_in_current_pass++;
			if (nodes_visited_in_current_pass >= nodes_visit_limit) {
				break;
			}
		}
		
		return found;
	}
	
	static result = function() {
		return {
			found,
			path,
			distance,
		};
	}
}