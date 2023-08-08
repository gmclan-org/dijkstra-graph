/// @returns {Struct.graph}
function graph() constructor {
	// based on:
	// https://github.com/mburst/dijkstras-algorithm/blob/master/dijkstras.js
	
	vertices = ds_map_create();
	
	static destroy = function() {
		var keys = ds_map_keys_to_array(self.vertices);
		for(var i = 0; i < array_length(keys); i++) {
			self.vertices[? keys[i] ].destroy();
			delete self.vertices[? keys[i] ];
		}
		ds_map_destroy(self.vertices);
	}
	
	/// @param {Struct.vertex} _vertex
	static add = function(_vertex) {
		self.vertices[? _vertex.id] = _vertex;
	}
	
	/// @param {String} _vertex_id
	static remove = function(_vertex_id) {
		if (self.vertices[? _vertex_id] != undefined) {
			self.vertices[? _vertex_id].destroy();
			ds_map_delete(self.vertices, _vertex_id);
		}
	}
	
	/// @param {String} a
	/// @param {String} b
	/// @param {Real} _dist
	static connect = function(a, b, _dist) {
		if (a == b) return false;

		var _va = self.get_vertex(a);
		var _vb = self.get_vertex(b);
	
		if (_va and _vb) {
			_va.connect(_vb, _dist);
			_vb.connect(_va, _dist); // back-version of connection
		} else {
			throw "one of vertices " + string(a) + "," + string(b) +" was not found";	
		}
	
		return true;
	}
	
	/// @param {String} a
	/// @param {String} b
	/// @return {Bool}
	static disconnect = function(a, b) {
		if (a == b) return false;
	
		var _va = self.get_vertex(a);
		var _vb = self.get_vertex(b);
	
		if (_va and _vb) {
			_va.disconnect(_vb.id);
			_vb.disconnect(_va.id);
		} else {
			throw "one of vertices " + string(a) + "," + string(b) +" was not found";	
		}
	
		return true;
	}
	
	/// @param {String} _id
	/// @returns {Struct.vertex}
	static get_vertex = function(_id) {
		return self.vertices[? _id];
	}
	
	/// @param {String} _start
	/// @param {String} _end
	static find_way = function(_start, _end) {
		// feather ignore GM2044
		var keys = ds_map_keys_to_array(self.vertices);
			array_sort(keys, true);
		var dist = ds_map_create();
		var prev = ds_map_create();
		var nodes = ds_priority_create();
		var path = [];
		var path_len = 0;
		var i;
		
		for (var i = 0, n = array_length(keys); i < n; i++) {
			if (keys[i] == _start) {
				// it's me :)
				dist[? keys[i]] = 0;
				ds_priority_add(nodes, keys[i], 0);
			} else {
				dist[? keys[i]] = infinity;
				ds_priority_add(nodes, keys[i], infinity);
			}
			prev[? keys[i]] = undefined;
		}
		
		var _time = current_time;
		
		graph_debug("new search ...");
		
		var smallest = undefined; // get node letter
		while (!ds_priority_empty(nodes)) {
			smallest = ds_priority_find_min(nodes);
			ds_priority_delete_min(nodes);
			
			graph_debug($"... traversing {smallest}");
			
			if (smallest == _end) {
				path = [];
				
				while(prev[? smallest] != undefined) {
					array_push(path, smallest);
					smallest = prev[? smallest];
				}
				
				array_push(path, _start);
				break;
				// ends
			}
		
		
			if (smallest == undefined or dist[? smallest] == infinity) {
				continue;
			}
			
			var _vertex_keys = self.vertices[? smallest].keys;
			var neighbor = undefined, len = infinity;
			// iterate over all neighbor vertices for this vertice
			for(var i = 0, n = array_length(_vertex_keys); i < n; i++) {
				neighbor = _vertex_keys[i];
				
				len = dist[? smallest] + self.vertices[? smallest].connections[? neighbor];
				
				if(len < dist[? neighbor]) {
					dist[? neighbor] = len;
					prev[? neighbor] = smallest;

					ds_priority_add(nodes, neighbor, len);
		        }
			}
		
		}
		
		// don't forget about cleanup
		ds_map_destroy(dist);
		ds_map_destroy(prev);
		ds_priority_destroy(nodes);
		
		var reversed_path = array_reverse(path);
		//while(array_length(path)) {
		//	array_push(reversed_path, array_pop(path));
		//}
		for (var i = 1, n = array_length(reversed_path); i < n; i++) {
			path_len += self.vertices[? reversed_path[i-1]].connections[? reversed_path[i]];
		}
		
		graph_debug(string("Searching took {0} ms.", string_format(current_time - _time, 5, 10)));
		graph_debug($"Found way with distance {path_len} trough {reversed_path}.");
		
		return {
			path: reversed_path,
			distance: path_len,
		};
	}
	
	return self;
}

#macro OPTION_SHOW_GRAPH_DEBUG true
function graph_debug(_t) {
	if (OPTION_SHOW_GRAPH_DEBUG) {
		show_debug_message(_t);
	}
}

