#include <flutter/runtime_effect.glsl>

precision highp float;

out vec4 fragColor;

layout(location = 0) uniform vec4 inputVignetteParams; // 使用 vec4 存储 (centerX, centerY, start, end)
layout(location = 1) uniform vec2 screenSize;          // 屏幕尺寸
uniform sampler2D inputImageTexture;

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    lowp vec3 rgb = texture(inputImageTexture, textureCoordinate).rgb;

    // 距离中心点的距离
    lowp float d = distance(textureCoordinate, vec2(inputVignetteParams.x, inputVignetteParams.y));

    // 计算暗角效果的比例
    lowp float percent = smoothstep(inputVignetteParams.z, inputVignetteParams.w, d); // 使用 start 和 end

    // 使用黑色固定颜色
    fragColor = vec4(mix(rgb, vec3(0.0, 0.0, 0.0), percent), 1.0);
}
