/// @param {String} name
/// @returns {Struct.vertex}
function vertex(_id) constructor {
	id = _id;
	connections = ds_map_create();
	
	/// @param {Struct.Vertex}
	/// @param {Real}
	static connect = function(vertex, distance) {
		if (vertex.id != id) {
			self.connections[? vertex.id] = distance;
		}
	}
	
	/// @param {Struct.Vertex}
	/// @param {Real}
	static disconnect = function(vertex_id) {
		if (self.connections[? vertex_id] != undefined) {
			ds_map_delete(self.connections, vertex_id);
		}
	}
	
	/// Call this before calling delete or losing reference
	static destroy = function() {
		ds_map_destroy(self.connections);
	}
	
	return self;
}