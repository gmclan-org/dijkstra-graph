/// @param {String} a
/// @param {String} b
function connect_points(gr, a, b){

	if (a == b) return false;

	var _va = gr.get_vertex(a);
	var _vb = gr.get_vertex(b);
	var _dist = objects_distance_by_name(a, b);
	
	if (_va and _vb) {
		_va.connect(_vb, _dist);
		_vb.connect(_va, _dist); // back-version of connection
	} else {
		throw "one of vertexes " + string(a) + "," + string(b) +" was not found";	
	}
	
	return true;
}