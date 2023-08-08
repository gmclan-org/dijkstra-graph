/// @returns {Struct.graph}
function graph() constructor {
	// based on:
	// https://github.com/mburst/dijkstras-algorithm/blob/master/dijkstras.js
	
	vertices = ds_map_create();
	
	static destroy = function() {
		var keys = ds_map_keys_to_array(self.vertices);
		for(var i = 0; i < array_length(keys); i++) {
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
			//array_sort(keys, true);
		var dist = ds_map_create();
		var prev = ds_map_create();
		var nodes = ds_priority_create();
		var i;
		
		for (var i = 0, n = array_length(keys); i < n; i++) {
			if (keys[i] == _start) {
				// it's this node, so distance to it is 0 :)
				dist[? keys[i]] = 0;
			} else {
				dist[? keys[i]] = infinity;
			}
			ds_priority_add(nodes, keys[i], dist[? keys[i]]);
			prev[? keys[i]] = undefined;
		}
		
		var _time = current_time;
		
		graph_debug($"new search from {_start} to {_end}...");
		
		var smallest = undefined; // get node letter
		while (!ds_priority_empty(nodes)) {
			smallest = ds_priority_find_min(nodes);
			if (smallest == _end) {
				break;
				// ends
			}
			
			ds_priority_delete_min(nodes);
			
			graph_debug($"... traversing {smallest}");
		
			if (smallest == undefined or dist[? smallest] == infinity) {
				continue;
			}
			
			var _vertex_keys = self.vertices[? smallest].keys;
			var neighbor = undefined, len = infinity;
			// iterate over all neighbor vertices for this vertice
			for(var i = 0, n = array_length(_vertex_keys); i < n; i++) {
				neighbor = _vertex_keys[i];
				graph_debug($"... >> {neighbor}");
				
				len = dist[? smallest] + self.vertices[? smallest].connections[$ neighbor];
				
				if(len < dist[? neighbor]) {
					dist[? neighbor] = len;
					prev[? neighbor] = smallest;

					ds_priority_add(nodes, neighbor, len);
		        }
			}
		
		}
		
		// now prepare results
		var path = [];
		var distance = 0;
		path = [_start];
				
		while(prev[? smallest] != undefined) {
			array_insert(path, 1, smallest);
			smallest = prev[? smallest];
		}
		
		for (var i = 1, n = array_length(path); i < n; i++) {
			distance += self.vertices[? path[i-1]].connections[$ path[i]];
		}
		
		graph_debug(string("Searching took {0} ms.", string_format(current_time - _time, 5, 10)));
		graph_debug($"Found way with distance {distance} trough {path}.");
		
		// cleanup
		// don't forget about cleanup
		ds_map_destroy(dist);
		ds_map_destroy(prev);
		ds_priority_destroy(nodes);
		
		//return
		return {
			path,
			distance,
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

