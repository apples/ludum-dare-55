shader_type spatial;
render_mode unshaded;

uniform sampler2D color_texture;
uniform float time_scale = 1.0;
uniform vec2 uv_scale = vec2(1, 1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 color = texture(color_texture, uv_scale * UV + vec2(time_scale * TIME, 0));
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
