#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float noiseStrength;  // 噪点强度
layout(location = 1) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

// 随机生成噪点
float random(vec2 coord) {
    return fract(sin(dot(coord.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 调整颜色并添加噪点
vec4 applyNoise(vec4 color, float strength, vec2 uv) {
    float noise = random(uv) * 2.0 - 1.0;  // 随机噪点值，范围 [-1, 1]
    vec3 noisyColor = color.rgb + noise * strength;  // 根据强度增加噪点
    return vec4(clamp(noisyColor, 0.0, 1.0), color.a);  // 保证颜色值在 [0, 1] 范围内
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 应用噪点效果
    fragColor = applyNoise(textureColor, noiseStrength, textureCoordinate);
}
