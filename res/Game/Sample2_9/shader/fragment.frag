precision mediump float;
//���մӶ�����ɫ�������Ĳ���
varying float vY;  


void main()                         
{    
    const vec4 aColor=vec4(1,1,0,1);
    const vec4 bColor=vec4(1,0,1,1);
   
    float factor=step(0.5,fract(vY/4.0));                   //step(edge, x)  ���x<edge �򷵻�0.0  ���򷵻�1.0
   
    gl_FragColor = aColor*factor+(1.0-factor)*bColor;   	//fract   ����x-floor(x)
}   