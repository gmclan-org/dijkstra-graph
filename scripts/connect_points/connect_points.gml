/// @param {String} a
/// @param {String} b
function connect_points(gr, a, b){
	return gr.connect(a, b, objects_distance_by_name(a, b));
}