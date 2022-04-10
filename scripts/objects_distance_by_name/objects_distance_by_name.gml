function objects_distance_by_name(a, b){
	var _a = 0, _b = 0;
	
	with(obj_node) {
		if (a == name) {
			_a = id;
		}
		if (b == name) {
			_b = id;
		}
	}
	
	if (_a and _b) {
		return round(point_distance(_a.x, _a.y, _b.x, _b.y));
	}
	
	return 0;
}