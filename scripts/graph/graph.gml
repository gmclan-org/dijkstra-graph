/// @returns {Struct.Graph}
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
	
	/// @param {Struct.vertex} vertex
	static add = function(_vertex) {
		self.vertices[? _vertex.id] = _vertex;
	}
	
	/// @param {String} vertex
	static remove = function(_vertex_id) {
		ds_map_delete(self.vertices, _vertex_id);
	}
	
	/// @return {Struct.vertex}
	static get_vertex = function(id) {
		return self.vertices[? id];
	}
	
	/// @param {string} start
	/// @param {string end
	static find_way = function(_start, _end) {
		var keys = ds_map_keys_to_array(self.vertices);
			array_sort(keys, true);
		var dist = ds_map_create();
		var prev = ds_map_create();
		var nodes = new priority_queue();
		var path = [];
		var path_len = 0;
		var i;
		
		for (i = 0; i < array_length(keys); i++) {
			if (keys[i] == _start) {
				// it's me :)
				dist[? keys[i]] = 0;
				nodes.enqueue(keys[i], 0); 
			} else {
				dist[? keys[i]] = infinity;
				nodes.enqueue(keys[i], infinity);
			}
			prev[? keys[i]] = undefined;
		}
		
		var smallest = undefined; // get node letter
		while (!nodes.is_empty()) {
			smallest = nodes.dequeue();
			
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
			
			var _vertex_keys = ds_map_keys_to_array(self.vertices[? smallest].connections);
			var neighbor, len;
			// iterate over all neighbor vertices for this vertice
			for(i = 0; i < array_length(_vertex_keys); i++) {
				neighbor = _vertex_keys[i];
				
				len = dist[? smallest] + self.vertices[? smallest].connections[? neighbor];
				
				if(len < dist[? neighbor]) {
		          dist[? neighbor] = len;
		          prev[? neighbor] = smallest;

		          nodes.enqueue(neighbor, len);
		        }
			}
		
		}
		
		// don't forget about cleanup
		ds_map_destroy(dist);
		ds_map_destroy(prev);
		
		var reversed_path = [];
		while(array_length(path)) {
			array_push(reversed_path, array_pop(path));
		}
		for (var i = 1; i < array_length(reversed_path); i++) {
			path_len += self.vertices[? reversed_path[i-1]].connections[? reversed_path[i]];
		}
		
		return {
			path: reversed_path,
			distance: path_len,
		};
	}
	
	return self;
}



