#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float temperature; // 色温调整参数
layout(location = 1) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

// 色温调整函数：根据色温调整蓝色和红色通道
vec3 adjustTemperature(vec3 color, float temp) {
    // 根据温度调整红色和蓝色通道
    float t = clamp(temp, -1.0, 1.0);
    vec3 warmFilter = vec3(1.0, 1.0, 1.0);  // 默认白平衡
    if (t > 0.0) {
        // 提升色温：增加红黄色调
        warmFilter.r = 1.0 + t * 0.3;  // 增加红色
        warmFilter.b = 1.0 - t * 0.3;  // 减少蓝色
    } else {
        // 降低色温：增加蓝色调
        warmFilter.r = 1.0 + t * 0.3;  // 减少红色
        warmFilter.b = 1.0 - t * 0.3;  // 增加蓝色
    }
    return color * warmFilter;
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 调整色温
    vec3 adjustedColor = adjustTemperature(textureColor.rgb, temperature);

    fragColor = vec4(adjustedColor, textureColor.a); // 保留 alpha 通道
}
