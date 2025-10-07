#version 460

in vec3 vaPosition;
in vec2 vaUV0;
in vec4 vaColor;

uniform vec3 chunkOffset;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewInverse;

out vec2 texCoord;
out vec3 foliageColor;

void main(){
    texCoord = vaUV0;
    foliageColor = vaColor.rgb;

    //curve horizon
    vec3 worldSpaceVertexPosition = cameraPosition + (gbufferModelViewInverse * modelViewMatrix * vec4 (vaPosition + chunkOffset, 1)).xyz;
    float distanceFromCamera = distance(worldSpaceVertexPosition, cameraPosition);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset - 0.1 * distanceFromCamera, 1);
}