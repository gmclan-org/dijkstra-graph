

	var _reset = false;
	
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
		route_result = "";
	}


