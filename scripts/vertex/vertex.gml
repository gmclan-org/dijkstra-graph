/// @param {String} _id
/// @returns {Struct.vertex}
function vertex(_id) constructor {
	id = _id;
	connections = ds_map_create();
	
	/// @param {Struct.vertex} vertex
	/// @param {Real} distance
	static connect = function(vertex, distance) {
		if (vertex.id != id) {
			self.connections[? vertex.id] = distance;
		}
	}
	
	/// @param {String} vertex_id
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