shader_type spatial;

// Set to 0 to disable wiggle
uniform float wigglyNess = 1.f;

uniform sampler2D albedoTexture;
uniform sampler2D damagedTexture;

uniform float healthFraction = 0.5f;
uniform vec4 tint = vec4(1, 1, 1, 1);

void vertex(){
    vec3 worldVertex = (WORLD_MATRIX * vec4(VERTEX, 1.0)).xyz;
    float size = length(VERTEX);
    
    VERTEX.x += sin(VERTEX.z * 2.f + sign(VERTEX.x) * TIME / 4.0f) / 10.f
        * wigglyNess * size;
    VERTEX.z += sin(VERTEX.x * 2.f - sign(VERTEX.z) * TIME / 4.0f) / 10.f
        * wigglyNess * size;
}

void fragment(){
    vec4 normal = texture(albedoTexture, UV);
    vec4 damaged = texture(damagedTexture, UV);
    vec4 final = ((normal * healthFraction) + 
        (damaged * (1.f - healthFraction))) * tint;
    ALBEDO = final.rgb;
    ALPHA = final.a;
}