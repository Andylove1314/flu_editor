#include <flutter/runtime_effect.glsl>
precision mediump float;

layout(location = 0) uniform lowp float inputHue;  // 色调输入
layout(location = 1) uniform vec2 screenSize;  // 屏幕尺寸

uniform lowp sampler2D inputImageTexture;

out vec4 fragColor;

// 将 RGB 颜色转换为 HSL
vec3 rgbToHsl(vec3 color) {
    float maxC = max(max(color.r, color.g), color.b);
    float minC = min(min(color.r, color.g), color.b);
    float delta = maxC - minC;

    float h = 0.0, s = 0.0, l = (maxC + minC) / 2.0;

    if (delta > 0.0) {
        if (maxC == color.r) {
            h = mod(((color.g - color.b) / delta), 6.0);
        } else if (maxC == color.g) {
            h = (color.b - color.r) / delta + 2.0;
        } else {
            h = (color.r - color.g) / delta + 4.0;
        }
        s = delta / (1.0 - abs(2.0 * l - 1.0));
    }
    return vec3(h, s, l);
}

// Helper function to calculate the RGB value based on hue
float hueToRgb(float p, float q, float t) {
    if (t < 0.0) t += 1.0;
    if (t > 1.0) t -= 1.0;
    if (t < 1.0 / 6.0) return p + (q - p) * 6.0 * t;
    if (t < 1.0 / 2.0) return q;
    if (t < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
    return p;
}

// 将 HSL 颜色转换为 RGB
vec3 hslToRgb(vec3 hsl) {
    float h = hsl.x;
    float s = hsl.y;
    float l = hsl.z;

    float r, g, b;

    if (s == 0.0) {
        r = g = b = l;  // achromatic
    } else {
        float q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
        float p = 2.0 * l - q;
        r = hueToRgb(p, q, h + 1.0 / 3.0);
        g = hueToRgb(p, q, h);
        b = hueToRgb(p, q, h - 1.0 / 3.0);
    }

    return vec3(r, g, b);
}

// 调整饱和度和亮度
vec3 adjustSaturationLightness(vec3 hsl, float saturationAdjustment, float lightnessAdjustment) {
    hsl.y = clamp(hsl.y + saturationAdjustment, 0.0, 1.0); // 调整饱和度
    hsl.z = clamp(hsl.z + lightnessAdjustment, 0.0, 1.0); // 调整亮度
    return hsl;
}

// 应用色调效果
vec4 applyHue(vec4 color, float hueAdjustment) {
    vec3 hsl = rgbToHsl(color.rgb);
    hsl.x = mod(hsl.x + hueAdjustment, 1.0);  // 调整色调
    hsl = adjustSaturationLightness(hsl, 0.05, 0.0); // 调整饱和度，亮度保持不变，降低饱和度调整
    vec3 newRgb = hslToRgb(hsl);
    newRgb = mix(color.rgb, newRgb, 0.3); // 减少混合比例，保留更多原始颜色
    return vec4(newRgb, color.a); // 去掉 gamma 校正
}

void main() {
    vec2 textureCoordinate = FlutterFragCoord().xy / screenSize;
    vec4 textureColor = texture(inputImageTexture, textureCoordinate);

    // 应用色调效果，调整幅度为较小值
    float hueAdjustment = inputHue * 0.1; // 缩小色调调整幅度
    fragColor = applyHue(textureColor, hueAdjustment);
}
