shader_type canvas_item;

uniform float time : hint_range(0, 10) = 0.0;
uniform float sway_strength = 5.0;
uniform float sway_speed = 1.5;

void fragment() {
    vec2 uv = UV;
    float offset = sin(uv.y * 10.0 + TIME * sway_speed) * sway_strength * (1.0 - uv.y);
    COLOR = texture(TEXTURE, uv + vec2(offset / TEXTURE_PIXEL_SIZE.x, 0.0));
}
