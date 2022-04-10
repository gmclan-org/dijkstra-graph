

	if (mode == editor_mode.finding) {
		if (node1 != -1 and node2 != -1) {
			node1 = -1;
			node2 = -1;
			route = [];
		} else if (node1 == -1) {
			node1 = instance_nearest(mouse_x, mouse_y, obj_node);
		} else {
			node2 = instance_nearest(mouse_x, mouse_y, obj_node);
		
			show_debug_message("searching...");
			var _res = global.my_graph.find_way(node1.name, node2.name);
		
			show_debug_message(_res);
		
			route = [];
			for (var i = 0; i < array_length(_res); i++) {
				with(obj_node) {
					if (name == _res[i]) {
						array_push(other.route, id);
					}
				}
			}
			
			if (array_length(route) > 1) {
				route_result = "Found";
			} else {
				route_result = "Can't find"
			}
			route_result += "  way from " + node1.name + " to " + node2.name;
		
			show_debug_message(route);
		}
	}
	
	
	if (mode == editor_mode.node_creating) {
		var near = instance_nearest(mouse_x, mouse_y, obj_node);
		
		if (near <= 0 or point_distance(mouse_x, mouse_y, near.x, near.y) > 50) {
			create_named_node(global.my_graph, mouse_x, mouse_y);
		}
	}
	
	if (mode == editor_mode.connecting) {
		if (node1 == -1) {
			node1 = instance_nearest(mouse_x, mouse_y, obj_node);
		} else {
			node2 = instance_nearest(mouse_x, mouse_y, obj_node);
			
			connect_points(global.my_graph, node1.name, node2.name);
			connect_points(global.my_graph, node2.name, node1.name);
			
			node1 = -1;
			node2 = -2;
		}
		
	}



