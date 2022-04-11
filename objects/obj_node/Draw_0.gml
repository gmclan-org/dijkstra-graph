

	draw_set_color(c_white);
	draw_self();
	
	draw_text(x + 5, y + 5, name);
	
	if (v != undefined) {
		var _k = ds_map_keys_to_array(v.connections);
		for(var i = 0; i<array_length(_k); i++) {
			with(obj_node) {
				if (name == _k[i]) {
					draw_line(other.x, other.y, x, y);
					if (display_distances) {
						var _x = (other.x + x) / 2, _y = (other.y + y) / 2;
						draw_set_color(c_black);
						draw_set_alpha(0.5);
						draw_rectangle(_x, _y, _x + string_width(other.v.connections[? _k[i]]), _y + 20, false);
						
						draw_set_color(c_white);
						draw_set_alpha(1);
						draw_text(
							_x,
							_y,
							string(other.v.connections[? _k[i]])
						);
					}
				}
			}
		}
	}

