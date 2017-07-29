#define PROCESSING_COLOR_SHADER
 
uniform float maxDepth;
 
void main(void){ 
  float depth = gl_FragCoord.z / gl_FragCoord.w; 
  gl_FragColor = vec4(vec3(depth/maxDepth), 1); 
}