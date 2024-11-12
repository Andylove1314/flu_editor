#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform vec3 inputBalance; // 白平衡输入 vec3
layout(location = 1) uniform vec2 screenSize;   // 屏幕尺寸

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 应用白平衡调整
    vec3 adjustedColor = textureColor.rgb * inputBalance; // 使用 vec3 进行调整

    fragColor = vec4(adjustedColor, textureColor.a);
}
