shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable;
uniform sampler2D noise_texture2: repeat_enable;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float distortion = 0.005;
uniform vec2 speed = vec2(0.05, 0.05);
uniform vec2 speed2 = vec2(-0.05, -0.05);

void fragment() {
	// Use TIME to animate the noise
	//float t = TIME * time_speed;

	// Scale UVs for the noise texture; adjust factor (e.g. 4.0) for desired frequency
	//vec2 noise_uv = UV * 4.0 + vec2(t, t);

	// Sample noise texture (using RG channels) and remap from [0,1] to [-1,1]
	//vec2 noise_sample = texture(noise_texture, noise_uv).rg;
	//vec2 offset = (noise_sample * 2.0 - 1.0) * distortion_strength;
	//vec3 sample = texture(noise_texture, UV + TIME * time_speed).rgb;
	//ec2 offset = sample.rg * distortion_strength;


	// Offset the screen UV coordinates to create refraction/distortion
	//vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV + offset);
	//screen_color.rgb += sample.rgb * 0.1;
	//COLOR = screen_color;
	vec2 uv = UV + speed * TIME;
	vec2 uv2 = UV + speed2 * TIME;

	vec4 sample = texture(noise_texture, uv) * texture(noise_texture2, uv2);
	vec2 noise = 2.0 * sample.rg - vec2(1.0);
	COLOR = texture(TEXTURE, UV);
	COLOR *= texture(SCREEN_TEXTURE, SCREEN_UV + noise * distortion);
	vec4 top_light = smoothstep(0.48, 0.75, sample.r) * vec4(1.0);
	COLOR += top_light;
	//COLOR.r += step(0.5, noise.r);
}
