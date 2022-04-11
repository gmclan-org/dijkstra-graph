

	var _reset = false;
	
	if (keyboard_check_pressed(ord("R"))) {
		with(obj_node) { display_distances = !display_distances; }
		return;
	}
	
	if (keyboard_check_pressed(ord("Q"))) {
		mode = editor_mode.finding;
		_reset = true;
	}
	if (keyboard_check_pressed(ord("W"))) {
		mode = editor_mode.node_creating;
		_reset = true;
	}
	if (keyboard_check_pressed(ord("E"))) {
		mode = editor_mode.connecting;
		_reset = true;
	}
	
	if (_reset) {
		node1 = -1;
		node2 = -1;
		route = [];
		switch(mode) {
			case editor_mode.node_creating:
				route_result = "Press anywhere to create node, or drag existing";
				break;
			case editor_mode.connecting:
				route_result = "Press on first node. Left click creates connection, right click removes existing.";
				break;
			case editor_mode.finding:
				route_result = "Press on two nodes to find shortest way, click again to reset points";
				break;
			default:
				route_result = "";
		}
	}
	
	if (mode == editor_mode.node_creating) {
		if (node1 > -1) {
			
			var _n = node1;
			var _close = false;
			
			with (obj_node) {
				if (_n != id) {
					if (point_distance(mouse_x, mouse_y, x, y) < 50) _close = true;
				}
			}
			
			if (_close = false) {
				node1.x = mouse_x;
				node1.y = mouse_y;
			} else {
				node1.x = node1.xprevious;
				node1.y = node1.yprevious;
			}
		}
	}



