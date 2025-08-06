shader_type canvas_item;

uniform bool shouldSway = true;
uniform float sway_strength : hint_range(0.0, 50.0) = 10.0;
uniform float sway_speed : hint_range(0.1, 5.0) = 1.0;
uniform float wind_direction : hint_range(0.0, 6.28) = 0.0;
uniform float stem_height : hint_range(0.0, 1.0) = 0.1;
uniform float randomness : hint_range(0.0, 1.0) = 0.3;
uniform float time_offset : hint_range(0.0, 6.28) = 0.0;

void vertex() {
    if (shouldSway) {
        vec2 safe_uv = clamp(UV, vec2(0.0), vec2(1.0));
        
        float time_offset_final = TIME * sway_speed + time_offset;
        float random_offset = sin(VERTEX.x * 0.01 + VERTEX.y * 0.01) * randomness;

        float base_sway = sin(time_offset_final + random_offset + wind_direction) * sway_strength;

        float movement_factor = 0.0;
        float stem_denom = max(1e-4, 1.0 - stem_height);

        if (safe_uv.y < (1.0 - stem_height)) {
            movement_factor = (1.0 - stem_height - safe_uv.y) / stem_denom;
        }

        VERTEX.x += base_sway * movement_factor;
        VERTEX.y += cos(time_offset_final * 0.7 + random_offset) * sway_strength * 0.1 * safe_uv.y;
    }
}

void fragment() {
    COLOR = texture(TEXTURE, clamp(UV, vec2(0.0), vec2(1.0)));
}
