

	enum editor_mode {
		finding, // find shortest way
		node_creating, // add points
		connecting, // connect points
	}
	
	mode = editor_mode.finding;
	
	node1 = -1;
	node2 = -1;
	
	route = [];
	route_result = "";
	
	global.my_graph = graph_load();
	
	if (ds_map_size(global.my_graph.vertices) == 0) {
		global.my_graph.destroy();
		delete global.my_graph;
		
		global.my_graph = new graph();
		var g = global.my_graph;
		create_named_node(g, 64, 192);
		create_named_node(g, 320, 64);
		create_named_node(g, 352, 512);
		create_named_node(g, 704, 64);
		create_named_node(g, 736, 416);
		create_named_node(g, 864, 192);
	
		connect_points(g, "A", "B");
		connect_points(g, "A", "C");
		//connect_points(g, "A", "F");
		connect_points(g, "B", "E");
		connect_points(g, "C", "F");
		connect_points(g, "D", "F");
		connect_points(g, "E", "D");
		connect_points(g, "E", "F");
	
		graph_save(global.my_graph);
	}



