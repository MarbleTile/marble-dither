#version 150

uniform sampler2D DiffuseSampler;

uniform vec4 ColorModulate;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    vec4 pix = texture(DiffuseSampler, texCoord);
    vec3 color = pix.rgb;
    vec3 color_lin;
    color_lin.x = color.x <= 0.04045 ? color.x/12.92 : pow((color.x+0.055)/1.055, 2.4);
    color_lin.y = color.y <= 0.04045 ? color.y/12.92 : pow((color.y+0.055)/1.055, 2.4);
    color_lin.z = color.z <= 0.04045 ? color.z/12.92 : pow((color.z+0.055)/1.055, 2.4);
    float grey_lin = color_lin.x*0.2126 + color_lin.y*0.7152 + color_lin.z*0.0722;
    float grey_gam = grey_lin <= 0.0031308 ? 12.92*grey_lin : 1.055*pow(grey_lin, 1.0/2.4)-0.055;
    fragColor = vec4(grey_gam, grey_gam, grey_gam, pix.a) * ColorModulate;
}
