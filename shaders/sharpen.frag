#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float sharpenIntensity; // 锐化强度
layout(location = 1) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

vec4 sharpen(vec2 texCoord) {
    vec2 texOffset = 1.0 / screenSize; // 计算纹理偏移
    vec4 centerColor = texture(inputImageTexture, texCoord);

    // 锐化卷积核：强调中心像素，减去周围像素
    vec4 colorSum = centerColor * (1.0 + 4.0 * sharpenIntensity);  // 中心像素
    colorSum -= texture(inputImageTexture, texCoord + vec2(texOffset.x, 0.0)) * sharpenIntensity;  // 左
    colorSum -= texture(inputImageTexture, texCoord - vec2(texOffset.x, 0.0)) * sharpenIntensity;  // 右
    colorSum -= texture(inputImageTexture, texCoord + vec2(0.0, texOffset.y)) * sharpenIntensity;  // 上
    colorSum -= texture(inputImageTexture, texCoord - vec2(0.0, texOffset.y)) * sharpenIntensity;  // 下

    return colorSum;
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 sharpenedColor = sharpen(textureCoordinate);
    fragColor = sharpenedColor;
}
