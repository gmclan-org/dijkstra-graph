/// @returns {Struct.graph}
function graph() constructor {
	// based on:
	// https://github.com/mburst/dijkstras-algorithm/blob/master/dijkstras.js
	
	vertices = {};
	
	/// @param {Struct.vertex} _vertex
	static add = function(_vertex) {
		self.vertices[$ _vertex.id] = _vertex;
	}
	
	/// @param {String} _vertex_id
	static remove = function(_vertex_id) {
		if (self.vertices[$ _vertex_id] != undefined) {
			struct_remove(self.vertices, _vertex_id);
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
		return self.vertices[$ _id];
	}
	
	/// @param {String} _start
	/// @param {String} _end
	static find_way = function(_start, _end) {
		var _serach = new search(self, _start, _end);
		_serach.pass();
		return _serach.result;
	}
	
	return self;
}

#macro OPTION_SHOW_GRAPH_DEBUG true
function graph_debug(_t) {
	if (OPTION_SHOW_GRAPH_DEBUG) {
		show_debug_message(_t);
	}
}

