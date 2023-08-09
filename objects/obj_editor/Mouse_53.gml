

	if (mode == editor_mode.finding) {
		if (node1 != noone and node2 != noone) {
			node1 = noone;
			node2 = noone;
			route = [];
			route_result = "Select start point...";
		}
		
		if (node1 == noone) {
			var n = instance_nearest(mouse_x, mouse_y, obj_node);
			if point_distance(mouse_x, mouse_y, n.x, n.y) <= OPTION_EDITOR_SAFE_DISTANCE {
				node1 = n;
				route_result = "Select end point...";
			}
		} else {
			var n = instance_nearest(mouse_x, mouse_y, obj_node);
			if point_distance(mouse_x, mouse_y, n.x, n.y) > OPTION_EDITOR_SAFE_DISTANCE {
				exit;
			}
			
			node2 = n;
			route = [];
			
			if (node2 == node1) {
				route = [id];
				route_result = $"Both start and end node are \"{node2.name}\", no search will be performed.";
				exit;
			}
			
			var _search = new search(global.my_graph, node1.name, node2.name);
			_search.pass();
			var _res = _search.result();
		
			for (var i = 0; i < array_length(_res.path); i++) {
				with(obj_node) {
					if (name == _res.path[i]) {
						array_push(other.route, id);
					}
				}
			}
			
			route_result = " way from " + node1.name + " to " + node2.name;
			if (array_length(route) > 1) {
				route_result = $"Found {route_result}, distance: {_res.distance}px, time: {string_format(_res.time_taken, 1, 7)}ms (1 frame = {game_get_speed(gamespeed_microseconds)/1000}ms, so it was {string_format(_res.time_taken/(game_get_speed(gamespeed_microseconds)/1000)*100, 1, 4)}%)";
			} else {
				route_result = "Can't find" + route_result;
			}
		}
	}
	
	
	if (mode == editor_mode.node_creating) {
		var near = instance_nearest(mouse_x, mouse_y, obj_node);
		
		if (near == noone or point_distance(mouse_x, mouse_y, near.x, near.y) > OPTION_EDITOR_SAFE_DISTANCE) {
			create_named_node(global.my_graph, mouse_x, mouse_y);
		} else {
			node1 = near;
		}
	}
	
	if (mode == editor_mode.connecting) {
		if (node1 == noone) {
			node1 = instance_nearest(mouse_x, mouse_y, obj_node);
		} else {
			node2 = instance_nearest(mouse_x, mouse_y, obj_node);
			
			connect_points(global.my_graph, node1.name, node2.name);
			
			node1 = noone;
			node2 = noone;
		}
		
	}




