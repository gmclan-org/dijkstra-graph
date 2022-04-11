

	draw_set_color(c_white);
	draw_text(5, 5, "Q - search route, W - add nodes, E - connect nodes, R - display distances");
	draw_line(5 + mode * 150, 25, 155 + mode * 150, 25);
	draw_text(5, 30, route_result);

	if (mode == editor_mode.finding) {		
		draw_set_color(c_red);
		for (var i = 1; i < array_length(route); i++) {
			var _len = point_distance(route[i-1].x, route[i-1].y+2, route[i].x, route[i].y+2);
			var _dir = point_direction(route[i-1].x, route[i-1].y+2, route[i].x, route[i].y+2);
			draw_sprite_ext(spr_line, 0, route[i-1].x, route[i-1].y, _len, 1, _dir, c_red, 1);
		}
	
		if (node1 != -1) {
			draw_circle(node1.x, node1.y, 20, true);
		}
	
		if (node2 != -1) {
			draw_circle(node2.x, node2.y, 20, true);
		}
	
		draw_set_color(c_white);
	}
	
	if (mode == editor_mode.node_creating) {
		if (node1 > -1) {
			draw_set_color(c_green);
			draw_circle(node1.x, node1.y, 20, true);
		}
	}
	
	if (mode == editor_mode.connecting) {
		if (node1) {
			draw_set_color(c_orange);
			draw_circle(node1.x, node1.y, 20, true);
			
			draw_line(node1.x, node1.y, mouse_x, mouse_y);
		}
	}




