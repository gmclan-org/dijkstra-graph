

	if (editor_mode.node_creating) {
		var near = instance_nearest(mouse_x, mouse_y, obj_node);
		if (near and point_distance(mouse_x, mouse_y, near.x, near.y) < 50) {
			
			if (near.v != undefined) {
				var _keys = ds_map_keys_to_array(near.v.connections);
				for(var i = 0; i < array_length(_keys); i++) {
					disconnect_points(global.my_graph, near.name, _keys[i]);
				}
			}
			
			global.my_graph.remove(near.name);
			
			instance_destroy(near);
		}
	} else {
		node1 = -1;
		node2 = -1;
	}

