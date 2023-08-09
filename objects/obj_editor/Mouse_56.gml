

	if (mode == editor_mode.node_creating) {
		if (node1 != noone) {
			// update distances
			var connections_to_update = global.my_graph.vertices[$ node1.name].keys;
			
			for(var i = 0; i < array_length(connections_to_update); i++) {
				connect_points(global.my_graph, node1.name, connections_to_update[i]);
			}
		}
		node1 = noone;
	}
