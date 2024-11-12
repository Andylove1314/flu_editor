#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float shadowStrength;// 阴影强度
layout(location = 1) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

// 调整阴影的函数
vec3 adjustShadows(vec3 color, float strength) {
    // 计算颜色的亮度
    float luminance = dot(color, vec3(0.3, 0.59, 0.11));

    // 对暗部区域进行增强，避免影响亮部
    if (luminance < 0.5) {
        // 平滑过渡，增强暗部
        vec3 shadowAdjustment = color * (1.0 - strength * (0.5 - luminance) * 2.0);
        return mix(color, shadowAdjustment, strength);
    }
    return color;
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 调整阴影部分
    vec3 adjustedColor = adjustShadows(textureColor.rgb, 2.0 - shadowStrength);

    fragColor = vec4(adjustedColor, textureColor.a);// 保留 alpha 通道
}
