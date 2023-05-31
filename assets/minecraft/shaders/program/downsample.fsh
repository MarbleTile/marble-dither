#version 150

uniform sampler2D DiffuseSampler;

uniform vec4 ColorModulate;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    vec2 pos = texCoord * OutSize;
    vec2 step = vec2(1.0/OutSize.x, 1.0/OutSize.y);
    int cond_x = int(mod(pos.x, 4));
    int cond_y = int(mod(pos.y, 4));
    fragColor = texture(DiffuseSampler, vec2(texCoord.x - cond_x*step.x, texCoord.y - cond_y*step.y)) * ColorModulate;
}
