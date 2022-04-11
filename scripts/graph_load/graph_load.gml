function graph_load() {
	var g = new graph();
	
	ini_open("graph.ini");
		var _total_nodes = ini_read_real("graph", "total_nodes", 0);
		if (_total_nodes > 0) {
			var _nodes_names = [];
			for(var i = 0; i < _total_nodes; i++) {
				array_push(
					_nodes_names,
					create_named_node(
						g,
						ini_read_real("graph", "node_" + string(i) + "_x", 0),
						ini_read_real("graph", "node_" + string(i) + "_y", 0),
						ini_read_string("graph", "node_" + string(i), "")
					)
				);
			}
			// connect
			for(var i = 0; i < _total_nodes; i++) {
				var _total_connections = ini_read_real("graph", "connections_" + _nodes_names[i], 0);
				for(var j = 0; j < _total_connections; j++) {
					var _n1 = _nodes_names[i], _n2 = ini_read_string("graph", "connection_" + _nodes_names[i] + "_" + string(j), ""); // connection instead connections (mind "s")
					g.connect(
						_n1,
						_n2, 
						objects_distance_by_name(_n1, _n2)
					);
				}
			}
		}
	ini_close();
	
	return g;
}