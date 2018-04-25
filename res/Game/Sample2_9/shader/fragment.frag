precision mediump float;
//接收从顶点着色器过来的参数
varying float vY;  


void main()                         
{    
    const vec4 aColor=vec4(1,1,0,1);
    const vec4 bColor=vec4(1,0,1,1);
   
    float factor=step(0.5,fract(vY/4.0));                   //step(edge, x)  如果x<edge 则返回0.0  否则返回1.0
   
    gl_FragColor = aColor*factor+(1.0-factor)*bColor;   	//fract   返回x-floor(x)
}   