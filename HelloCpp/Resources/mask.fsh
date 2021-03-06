

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 v_texCoord;

uniform sampler2D CC_Texture0;

uniform vec2 texSize;
uniform float r;
uniform vec2 c;
uniform vec4 brightColor;
uniform vec4 darkColor;

void main() {
    vec2 texCoord=vec2(v_texCoord.s,1.0-v_texCoord.t);
    
    vec4 brightColor=max(brightColor,darkColor);
    vec4 darkColor=min(brightColor,darkColor);
    vec2 curPixelPos=vec2(texCoord.s*texSize.x,texCoord.t*texSize.y);//curPixel pos in world space
    float dis_curPixelToC=distance(curPixelPos,c);
    vec4 curPixelColor;
    if(dis_curPixelToC<r){
        //use the curve y=1/(r*r)*x*x-2/r*x+1
        //float temp=max(0.0,1.0-dis_curPixelToC/r);
        //float k=temp*temp;
        //curPixelColor=(brightColor-darkColor)*k+darkColor;
        
        //use the curve y=x
        curPixelColor=brightColor-(brightColor-darkColor)/r*dis_curPixelToC;
    }else{
        curPixelColor=darkColor;
    }
   	gl_FragColor=texture2D(CC_Texture0, texCoord)*curPixelColor;
}

