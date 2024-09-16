shader_type canvas_item;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	COLOR = vec4(0.0, 0.0, 0.0, tex_color.a);;
}

void light() {
	float mc = LIGHT_COLOR.r;
	if (LIGHT_COLOR.g > mc) {
		mc = LIGHT_COLOR.g;
	}
	if (LIGHT_COLOR.b > mc) {
		mc = LIGHT_COLOR.b;
	}
	
	LIGHT = texture(TEXTURE, UV) * vec4(vec3(mc), 1.0);
}
