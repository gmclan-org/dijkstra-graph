/// @param {Struct.graph} gr
function graph_save(gr) {
	var _txt = "[graph]\n";
	var _keys = struct_get_names(gr.vertices);
	
	/// gather data
	var _vertices_map = ds_map_create();
	
	for(var i = 0; i < array_length(_keys); i++) {	
		_vertices_map[? _keys[i]] = ds_map_create();
		var _vertices_map_keys = gr.vertices[$ _keys[i]].keys;
		for(var j = 0; j < array_length(_vertices_map_keys); j++) {
			_vertices_map[? _keys[i]][? _vertices_map_keys[j]] = 1;
		}
	}
	
	array_sort(_keys, true);
	
	// prepare ini
	_txt += "total_nodes = " + string(array_length(_keys)) + "\n";
	for(var i = 0; i < array_length(_keys); i++) {
		with (obj_node) {
			if (name == _keys[i]) {
				_txt += "node_" + string(i) + "=" + string(name) + "\n";
				_txt += "node_" + string(i) + "_x=" + string(x) + "\n";
				_txt += "node_" + string(i) + "_y=" + string(y) + "\n";
			}
		}
		
		var _vertices_map_keys = ds_map_keys_to_array(_vertices_map[? _keys[i]]);
		_txt += "connections_" + string(_keys[i]) + "=" + string(array_length(_vertices_map_keys) ?? 0) + "\n";
		for(var j = 0; j < array_length(_vertices_map_keys); j++) {
			var _n1 = _keys[i];
			var _n2 = _vertices_map_keys[j];
			
			_txt += "connection_" + string(_n1) + "_" + string(j) + "=" + string(_n2) + "\n";
			
			// delete opposite
			ds_map_delete(_vertices_map[? _n2], _n1);
		}
		ds_map_destroy(_vertices_map[? _keys[i]]);
	}
	ds_map_destroy(_vertices_map);
	
	var file = file_text_open_write("graph.ini");
	file_text_write_string(file, _txt);
	file_text_close(file);
}