#version 460 compatibility

out vec2 texCoord;
out vec4 blockColor;
out vec2 lightMapCoords;
out vec3 viewSpacePosition;

void main(){
    lightMapCoords =(gl_TextureMatrix[2] * gl_MultiTexCoord2).xy;

    blockColor = gl_Color;
    viewSpacePosition = (gl_ModelViewMatrix * gl_Vertex).xyz;

    gl_Position = ftransform();
}