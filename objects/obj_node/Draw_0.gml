

	draw_set_color(c_white);
	draw_self();
	
	draw_text(x + 5, y + 5, name);
	
	if (v != undefined) {
		var _k = ds_map_keys_to_array(v.connections);
		for(var i = 0; i<array_length(_k); i++) {
			with(obj_node) {
				if (name == _k[i]) {
					draw_line(other.x, other.y, x, y);
				}
			}
		}
	}





