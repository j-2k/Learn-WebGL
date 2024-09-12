attribute vec4 a_position;
attribute vec4 a_color;

//uniform vec2 u_resolution;
uniform mat4 u_matrix;
varying vec4 v_color;

uniform float u_fudgeFactor;

void main() {
  /*
  //clip space was from -1 to 1 with only gl_Position = a_position; (a pos is vec4 previously)
  //apply/multiply the matrix to the position
  vec2 position = (u_matrix * vec3(a_position, 1)).xy;

  //making the position from pixels to 0 to 1!
  vec2 uv01 = position/u_resolution;

  vec2 scaledUV02 = uv01 * 2.0;

  //shift the position from 0 to 2 to -1 to 1 back to clip space
  vec2 clipSpace = scaledUV02 - 1.0;

  //flip y to fit standard 2d graphics api coordinate system (0,0) at top left and was (0,0) at bottom left
  clipSpace *= vec2(1.0, -1.0);

  gl_Position = vec4(clipSpace, 0.0,1.0);

  all above is the old way of doing it it has been changed to the 1 liner below with the addition of the projection matrix!
  gl_Position = vec4((u_matrix * vec3(a_position, 1)).xy, 0, 1);
  */

  //Transforms the vertex position to clip space
  vec4 position = u_matrix * a_position;

  // Starting Projection - Adjust the z to divide by
  float zToDivideBy = 1.0 + position.z * u_fudgeFactor;
  gl_Position = vec4(position.xy / zToDivideBy, position.zw);

  //gl_Position = u_matrix * a_position;

  v_color = a_color;
}