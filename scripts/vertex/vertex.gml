/// @param {String} _id
/// @returns {Struct.vertex}
function vertex(_id) constructor {
	name = _id;
	connections = {};
	
	/// @param {Struct.vertex} _vertex
	/// @param {Real} _distance
	static connect = function(_vertex, _distance) {
		if (_vertex.name != name) {
			self.connections[$ _vertex.name] = _distance;
		}
	}
	
	/// @param {String} _key
	static disconnect = function(_key) {
		if (self.connections[$ _key] != undefined) {
			struct_remove(self.connections, _key);
		}
	}
	
	/// refreshes cache array with keys
	static keys = function() {
		return struct_get_names(self.connections);
	}
	
	return self;
}