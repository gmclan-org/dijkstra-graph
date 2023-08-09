/// @param {String} _name
/// @returns {Struct.sd_graph_vertex}
function sd_graph_vertex(_name) constructor {
	name = _name;
	connections = {};
	
	/// @param {Struct.sd_graph_vertex} _vertex
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

/// @param {String} _name
/// @param {Real} _x
/// @param {Real} _y
/// @returns {Struct.sd_graph_vertex_xy}
function sd_graph_vertex_xy(_name, _x, _y) : sd_graph_vertex(_name) constructor {
	x = _x;
	y = _y;
	
	static _connect = self.connect;
	
	/// @param {Struct.sd_graph_vertex_xy} _vertex
	/// @param {Real} _distance
	static connect = function(_vertex) {
		
		if (!is_instanceof(_vertex, sd_graph_vertex_xy)) {
			throw "only sd_graph_vertex_xy can be connected with another one.";
		}
		
		_connect(_vertex, point_distance(x,y, _vertex.x, _vertex.y));
	}
}