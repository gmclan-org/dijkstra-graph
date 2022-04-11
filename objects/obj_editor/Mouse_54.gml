

	if (mode == editor_mode.node_creating) {
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
	} else if (mode == editor_mode.connecting) {
		if (node1 > -1) {
			node2 = instance_nearest(mouse_x, mouse_y, obj_node);
			if (point_distance(mouse_x, mouse_y, node2.x, node2.y) < 50) {
				disconnect_points(global.my_graph, node1.name, node2.name);
			}
		} else {
			event_perform(ev_mouse, ev_global_left_press);
			return; //don't reset nodes
		}
	}
	
	node1 = -1;
	node2 = -1;


