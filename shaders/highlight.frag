#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float highlightStrength;  // 高光强度参数
layout(location = 1) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

// 调整高光的函数
vec3 adjustHighlights(vec3 color, float strength) {
    // 计算颜色亮度，亮度高于阈值的部分将增强
    float luminance = dot(color, vec3(0.3, 0.59, 0.11)); // 计算亮度
    vec3 highlightAdjustment = vec3(1.0);

    // 仅对亮度高的区域进行调整
    if (luminance > 0.7) { // 设定亮度阈值为0.7
        highlightAdjustment = mix(color, vec3(1.0, 1.0, 1.0), strength); // 混合白色以增强亮度
    }
    return mix(color, highlightAdjustment, strength); // 按比例调整高光
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 调整高光部分
    vec3 adjustedColor = adjustHighlights(textureColor.rgb, highlightStrength);

    fragColor = vec4(adjustedColor, textureColor.a);  // 保留 alpha 通道
}
