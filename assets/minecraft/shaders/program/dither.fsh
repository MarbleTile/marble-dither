#version 150

uniform sampler2D DiffuseSampler;

uniform mat4 map;

uniform vec4 ColorModulate;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    vec2 pos = texCoord * OutSize;
    int map_x = int(mod(pos.x, 4));
    int map_y = int(mod(pos.y, 4));
    float M = map[map_x][map_y] - 0.5;
    float spread = 0.9;
    int num_color = 2;
    vec4 delta = vec4(M*spread, M*spread, M*spread, 0.0);
    vec4 color = texture(DiffuseSampler, texCoord) + delta;

    fragColor = floor(color * (num_color-1) + 0.5)/(num_color-1) * ColorModulate;
}
