attribute vec3 a_position;  //顶点位置
attribute vec3 a_normal;    //顶点法向量
attribute vec2 a_texCoord;  //顶点纹理坐标

//用于传递给片元着色器的变量
varying float vY;  

void main()     
{    
   gl_Position = CC_MVPMatrix * vec4(a_position, 1);
   vY = a_position.y;
}                      