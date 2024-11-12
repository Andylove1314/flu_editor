#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float inputIntensityL;  // 滤镜强度
layout(location = 1) uniform lowp float noiseStrength;    // 噪点强度
layout(location = 2) uniform vec2 screenSize;

uniform lowp sampler2D inputImageTexture;
uniform mediump sampler2D inputTextureCubeDataL;

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

// 查找 LUT 滤镜颜色
vec4 lookupFrom2DTexture(vec3 textureColor) {
    float blueColor = textureColor.b * 63.0;

    vec2 quad1 = vec2(0.0, 0.0);
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);

    vec2 quad2 = vec2(0.0, 0.0);
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);

    vec2 texPos1 = vec2(0.0, 0.0);
    texPos1.x = (quad1.x * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.g);

    vec2 texPos2 = vec2(0.0, 0.0);
    texPos2.x = (quad2.x * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5 / 512.0 + ((0.125 - 1.0 / 512.0) * textureColor.g);

    vec4 newColor1 = texture(inputTextureCubeDataL, texPos1);
    vec4 newColor2 = texture(inputTextureCubeDataL, texPos2);

    return mix(newColor1, newColor2, fract(blueColor));
}

// 应用 LUT 滤镜并添加噪点
vec4 processColor(vec4 sourceColor, vec2 uv) {
    vec4 newColor = lookupFrom2DTexture(clamp(sourceColor.rgb, 0.0, 1.0));
    vec4 filteredColor = mix(sourceColor, vec4(newColor.rgb, sourceColor.w), inputIntensityL); // 应用 LUT 滤镜
    return applyNoise(filteredColor, noiseStrength, uv);  // 应用噪点效果
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    fragColor = processColor(textureColor, textureCoordinate);
}
