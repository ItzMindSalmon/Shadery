#version 460

uniform sampler2D gtexture;

in vec2 texCoord;
in vec3 foliageColor;

/* DRAWBUFFERS: 0 */
layout(location = 0) out vec4 outcolor0;

void main(){
    vec4 outputColorData = texture(gtexture, texCoord);
    vec3 albedo = pow(outputColorData.rgb, vec3(2.2)) * pow(foliageColor, vec3(2.2));
    float transparency = outputColorData.a;
    if(transparency < .1){
        discard;
    }
    outcolor0 = vec4(pow(albedo, vec3(1/2.2)), transparency);
}