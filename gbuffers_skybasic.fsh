#version 460 compatibility

/*This gonna work with the sky color thing*/

uniform float viewHeight;
uniform float viewWidth;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 skyColor;
uniform vec3 fogColor;

in vec4 starData;

float fogify(float x, float w){
    return w / (x * x + w);         // fog
}

vec3 calcSkyColor(vec3 pos){
    float upDot = dot(pos, gbufferModelView[1].xyz); // Uhhhhhh, sky color
    return mix(skyColor, fogColor, fogify(max(upDot, 0.0),0.25));
}

vec3 screenToView(vec3 screenPos){
    vec4 ndcPos = vec4(screenPos, 1.0) * 2.0 - 1.0;
    vec4 tmp = gbufferModelViewInverse* ndcPos;     // screen space to view space
    return tmp.xyz / tmp.w;
}

/* DRAWBUFFERS: 0 */
layout (location = 0) out vec4 color;

void main(){
    if (starData.a > 0.5){
        color = vec4(starData.rgb, 1.0);
    }else{
        vec3 pos = screenToView(vec3(gl_FragCoord.xy / vec2(viewWidth, viewHeight), 1.0));
        color = vec4(calcSkyColor(normalize(pos)), 1.0);
    }
}