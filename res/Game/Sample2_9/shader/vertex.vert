attribute vec3 a_position;  //����λ��
attribute vec3 a_normal;    //���㷨����
attribute vec2 a_texCoord;  //������������

//���ڴ��ݸ�ƬԪ��ɫ���ı���
varying float vY;  

void main()     
{    
   gl_Position = CC_MVPMatrix * vec4(a_position, 1);
   vY = a_position.y;
}                      