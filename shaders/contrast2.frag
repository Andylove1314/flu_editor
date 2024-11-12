#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float inputContrast; // 对比度输入
layout(location = 1) uniform vec2 screenSize;  // 屏幕尺寸

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

vec4 applyContrast(vec4 color, float contrast) {
    // 将颜色转换到范围[0,1]再调整对比度
    vec3 contrastedColor = ((color.rgb - 0.5) * contrast + 0.5);
    return vec4(contrastedColor, color.a);  // 保持alpha不变
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 应用对比度效果
    fragColor = applyContrast(textureColor, inputContrast);
}
