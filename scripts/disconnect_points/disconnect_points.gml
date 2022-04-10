/// @param {String} a
/// @param {String} b
function disconnect_points(gr, a, b){
	
	if (a == b) return false;
	
	var _va = gr.get_vertex(a);
	var _vb = gr.get_vertex(b);
	
	if (_va and _vb) {
		_va.disconnect(_vb.id);
		_vb.disconnect(_va.id);
	}
	
	return true;
}