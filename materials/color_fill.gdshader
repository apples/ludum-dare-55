shader_type canvas_item;

uniform vec4 fillColor;

void fragment() {
	//COLOR = vec4(fillColor, texture(TEXTURE, UV).a);
	COLOR = vec4(fillColor.rgb, COLOR.a * fillColor.a);
}
