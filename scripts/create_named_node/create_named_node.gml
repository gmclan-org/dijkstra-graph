function create_named_node(gr, x, y, give_name = "") {
	var names = "ABCDEFGHIJKLMNOPRSTUWXYZ";
	var possible = string_length(names);
	if (instance_number(obj_node) < possible) {
		var i = instance_create_layer(x, y, layer, obj_node);
		var n = 1;
		
		if (give_name = "") {
			var _new_name = "";
			repeat(possible) {
				_new_name = string_char_at(names, n);
				var _cnt = 0;
				with (obj_node) {
					if (name == _new_name) {
						_cnt++;
					}
				}
					
				if (_cnt == 0) {
					break;
				}
				n++;
			}
			give_name = _new_name;
		}
		
		i.name = give_name;
		i.v = new sd_graph_vertex(give_name);
		gr.add(i.v);
		return give_name;
	}
	return "?";
}