/// @param {String} _id
/// @returns {Struct.vertex}
function vertex(_id) constructor {
	id = _id;
	connections = ds_map_create();
	keys = [];
	
	/// @param {Struct.vertex} vertex
	/// @param {Real} distance
	static connect = function(vertex, distance) {
		if (vertex.id != id) {
			self.connections[? vertex.id] = distance;
			self._refreshKeys();
		}
	}
	
	/// @param {String} vertex_id
	static disconnect = function(vertex_id) {
		if (self.connections[? vertex_id] != undefined) {
			ds_map_delete(self.connections, vertex_id);
			self._refreshKeys();
		}
	}
	
	/// Call this before calling delete or losing reference
	static destroy = function() {
		ds_map_destroy(self.connections);
	}
	
	static _refreshKeys = function() {
		keys = ds_map_keys_to_array(connections);
	}
	
	return self;
}