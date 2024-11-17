shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform bool paused;

void vertex() {
    POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	ALBEDO = texture(SCREEN_TEXTURE, SCREEN_UV).xyz; // get camera
	if (paused) {
		ALBEDO = textureLod(SCREEN_TEXTURE, SCREEN_UV, 2.0).xyz; // blur
		// ALBEDO = vec3((ALBEDO.r + ALBEDO.g + ALBEDO.b) / 3.0); // make grayscale
	}
}