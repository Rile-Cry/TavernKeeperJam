shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	const float glow = 0.2;
	COLOR.rgb = vec3(COLOR.r +glow , COLOR.g + glow , COLOR.b + glow);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
