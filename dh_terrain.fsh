#version 460 compatibility

uniform sampler2D lightmap;
uniform sampler2D depthtex0;
uniform vec3 fogColor;
uniform float viewHeight;
uniform float viewWidth;

/* DRAWBUFFERS: 0 */
layout(location = 0) out vec4 outColor0;

in vec4 blockColor;
in vec2 lightMapCoords;
in vec3 viewSpacePosition;

void main(){
    vec3 lightColor = pow(texture(lightmap, lightMapCoords).rgb, vec3(2.2));

    vec4 outputColorData = blockColor;
    vec3 outputColor = outputColorData.rgb * lightColor;
    float transparency = outputColorData.a;
    if(transparency < .1){       // remove the color thing behind grasses and flowers
        discard;
    }
    vec2 texCoord = gl_FragCoord.xy / vec2(viewWidth, viewHeight);  //define the depth of an object
    float depth = texture(depthtex0, texCoord).r;
    if (depth != 1.0){
        discard;
    }

    float distanceFromCamera = distance(vec3(0), viewSpacePosition); 

    float maxFogDistance = 4000;
    float minFogDistance = 2500;

    float fogBlendValue = clamp((distanceFromCamera - minFogDistance) / (maxFogDistance - minFogDistance), 0, 1);

    outputColor = mix(outputColor, pow(fogColor, vec3(2.2)), fogBlendValue);

    outColor0 = pow(vec4(outputColor, transparency), vec4(1/2.2));
}