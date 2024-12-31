shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	const float max_glow = 0.05;
	const float glow_speed = 2.8;
	const float glow = 0.1;
	COLOR.rgb = vec3(COLOR.r +glow + sin(TIME*glow_speed)* max_glow, COLOR.g + glow+ sin(TIME*glow_speed)* max_glow , COLOR.b + glow + sin(TIME*glow_speed)* max_glow);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
