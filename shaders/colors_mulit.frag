#include <flutter/runtime_effect.glsl>

precision highp float;

out vec4 fragColor;

uniform sampler2D inputImageTexture;

// 输入参数
layout(location = 0) uniform float inputBrightness;      // 亮度输入
layout(location = 1) uniform float inputSaturation;      // 饱和度输入
layout(location = 2) uniform float inputContrast;         // 对比度输入
layout(location = 3) uniform float sharpenIntensity;       // 锐化强度输入
layout(location = 4) uniform float shadowStrength;         // 阴影强度输入
layout(location = 5) uniform float temperature;             // 色温调整参数
layout(location = 6) uniform float noiseStrength;           // 噪点强度输入
layout(location = 7) uniform float inputExposure;           // 曝光输入
layout(location = 8) uniform float inputVibrance;          // 鲜艳度输入
layout(location = 9) uniform float highlightStrength;       // 高光强度输入
layout(location = 10) uniform vec3 inputBalance;            // 白平衡输入
layout(location = 11) uniform vec4 inputVignetteParams;     // (centerX, centerY, start, end)
layout(location = 12) uniform vec2 screenSize;              // 屏幕尺寸

// 权重值，用于计算亮度
const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

// 处理颜色的函数（包含亮度、饱和度、对比度调整）
vec4 processColor(vec4 sourceColor) {
    // 曝光调整
    sourceColor.rgb *= pow(2.0, inputExposure);

    // 亮度调整
    sourceColor.rgb += vec3(inputBrightness * sourceColor.a);

    // 计算图像的亮度
    lowp float luminance = dot(sourceColor.rgb, luminanceWeighting);

    // 将图像转换为灰度色
    lowp vec3 greyScaleColor = vec3(luminance);

    // 应用饱和度调整
    sourceColor.rgb = mix(greyScaleColor, sourceColor.rgb, inputSaturation);

    // 应用鲜艳度调整
    lowp float average = (sourceColor.r + sourceColor.g + sourceColor.b) / 3.0;
    lowp float mx = max(sourceColor.r, max(sourceColor.g, sourceColor.b));
    lowp float amt = (mx - average) * (-inputVibrance * 3.0);
    sourceColor.rgb = mix(sourceColor.rgb, vec3(mx), amt);

    // 应用对比度调整
    sourceColor.rgb = ((sourceColor.rgb - 0.5) * inputContrast + 0.5);

    // 确保颜色在 [0, 1] 的范围内
    sourceColor.rgb = clamp(sourceColor.rgb, 0.0, 1.0);

    return sourceColor;
}

// 调整阴影的函数
vec3 adjustShadows(vec3 color, float strength) {
    float luminance = dot(color, vec3(0.3, 0.59, 0.11));

    if (luminance < 0.5) {
        vec3 shadowAdjustment = color * (1.0 - strength * (0.5 - luminance) * 2.0);
        return mix(color, shadowAdjustment, strength);
    }
    return color;
}

// 锐化处理的函数
vec4 sharpen(vec2 texCoord) {
    vec2 texOffset = 1.0 / screenSize;
    vec4 centerColor = texture(inputImageTexture, texCoord);

    vec4 colorSum = centerColor * (1.0 + 4.0 * sharpenIntensity);
    colorSum -= texture(inputImageTexture, texCoord + vec2(texOffset.x, 0.0)) * sharpenIntensity;
    colorSum -= texture(inputImageTexture, texCoord - vec2(texOffset.x, 0.0)) * sharpenIntensity;
    colorSum -= texture(inputImageTexture, texCoord + vec2(0.0, texOffset.y)) * sharpenIntensity;
    colorSum -= texture(inputImageTexture, texCoord - vec2(0.0, texOffset.y)) * sharpenIntensity;

    return colorSum;
}

// 色温调整函数
vec3 adjustTemperature(vec3 color, float temp) {
    float t = clamp(temp, -1.0, 1.0);
    vec3 warmFilter = vec3(1.0);
    if (t > 0.0) {
        warmFilter.r = 1.0 + t * 0.3;
        warmFilter.b = 1.0 - t * 0.3;
    } else {
        warmFilter.r = 1.0 - (-t * 0.3);
        warmFilter.b = 1.0 + (-t * 0.3);
    }
    return color * warmFilter;
}

// 随机生成噪点
float random(vec2 coord) {
    return fract(sin(dot(coord.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// 调整颜色并添加噪点
vec4 applyNoise(vec4 color, float strength, vec2 uv) {
    // 扩大噪点的粒度，增大噪点的幅度
    float noise = (random(uv) * 2.0 - 1.0) * 1.2;  // 乘以更大的常数，比如1.5，来增大噪点幅度
    vec3 noisyColor = color.rgb + noise * strength;
    return vec4(clamp(noisyColor, 0.0, 1.0), color.a);
}

// 添加高光的函数
vec3 addHighlights(vec3 color, float strength) {
    float luminance = dot(color, vec3(0.3, 0.59, 0.11));

    if (luminance > 0.8) {
        return color + (vec3(1.0) - color) * strength;
    }
    return color;
}

// 暗角效果函数
vec3 applyVignette(vec3 color, vec2 textureCoordinate) {
    // 计算当前像素与暗角中心点的距离
    lowp float d = distance(textureCoordinate, vec2(inputVignetteParams.x, inputVignetteParams.y));

    // 反向控制 start：inputVignetteParams.z 越大，start 越小
    lowp float start = 1.0 - inputVignetteParams.z;  // start 随 z 变小
    lowp float end = inputVignetteParams.w;          // end 不变，保持用户输入值

    // 使用 smoothstep 创建平滑的暗角效果
    lowp float percent = smoothstep(start, end, d);

    // 通过混合黑色和原始颜色来应用暗角效果
    return mix(color, vec3(0.0), percent);
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 应用白平衡调整
    vec3 adjustedColor = textureColor.rgb * inputBalance;

    // 应用亮度、饱和度、对比度、鲜艳度调整
    vec4 processedColor = processColor(vec4(adjustedColor, textureColor.a));

    // 调整阴影部分
    vec3 adjustedColorWithShadows = adjustShadows(processedColor.rgb, shadowStrength);

    // 调整色温
    vec3 temperatureAdjustedColor = adjustTemperature(adjustedColorWithShadows, temperature);

    // 先应用噪点效果
    vec4 noisyColor = applyNoise(vec4(temperatureAdjustedColor, 1.0), noiseStrength, textureCoordinate);

    // 应用锐化处理
    vec4 sharpenedColor = sharpen(textureCoordinate);

    // 添加高光效果
    vec3 highlightedColor = addHighlights(noisyColor.rgb, highlightStrength);

    // 应用暗角效果
    vec3 vignettedColor = applyVignette(highlightedColor, textureCoordinate);

    // 结合处理后的颜色与锐化后的颜色
    fragColor = vec4(mix(vignettedColor, sharpenedColor.rgb, sharpenIntensity), textureColor.a);
}

