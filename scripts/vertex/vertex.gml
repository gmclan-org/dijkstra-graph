/// @param {String} _id
/// @returns {Struct.vertex}
function vertex(_id) constructor {
	id = _id;
	connections = {};
	keys = array_create(0, "");
	
	/// @param {Struct.vertex} _vertex
	/// @param {Real} _distance
	static connect = function(_vertex, _distance) {
		if (_vertex.id != id) {
			self.connections[$ _vertex.id] = _distance;
			self._refreshKeys();
		}
	}
	
	/// @param {String} _key
	static disconnect = function(_key) {
		if (self.connections[$ _key] != undefined) {
			struct_remove(self.connections, _key);
			self._refreshKeys();
		}
	}
	
	/// refreshes cache array with keys
	static _refreshKeys = function() {
		self.keys = struct_get_names(self.connections);
	}
	
	return self;
}