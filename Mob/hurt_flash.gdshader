shader_type canvas_item;

const vec4 color = vec4(255, 255, 255, 255);
uniform bool visible = false;

void fragment() {
	float alpha = COLOR.a;
	COLOR = mix(COLOR, color, float(visible));
	COLOR.a = alpha;
}