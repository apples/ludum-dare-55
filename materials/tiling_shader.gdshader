shader_type canvas_item;

void fragment() {
	vec2 pos = UV;
	//pos.x = pos.x + TIME * -0.10;
	pos += TIME * vec2(.05, -.1);
	COLOR = texture(TEXTURE, pos);
}
