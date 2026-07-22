#define UI0 1597334673U
#define UI1 3812015801U
#define UI2 uvec2(UI0, UI1)
#define UI3 uvec3(UI0, UI1, 2798796415U)
#define UIF (1. / float(0xffffffffU))

// Hash by David_Hoskins
vec3 hash33(vec3 p)
{
    uvec3 q = uvec3(ivec3(p)) * UI3;
    q = (q.x ^ q.y ^ q.z)*UI3;
    return -1. + 2. * vec3(q) * UIF;
}

// Gradient noise by iq
float gnoise(vec3 x)
{
    // grid
    vec3 p = floor(x);
    vec3 w = fract(x);

    // quintic interpolant
    vec3 u = w * w * w * (w * (w * 6. - 15.) + 10.);

    // gradients
    vec3 ga = hash33(p + vec3(0., 0., 0.));
    vec3 gb = hash33(p + vec3(1., 0., 0.));
    vec3 gc = hash33(p + vec3(0., 1., 0.));
    vec3 gd = hash33(p + vec3(1., 1., 0.));
    vec3 ge = hash33(p + vec3(0., 0., 1.));
    vec3 gf = hash33(p + vec3(1., 0., 1.));
    vec3 gg = hash33(p + vec3(0., 1., 1.));
    vec3 gh = hash33(p + vec3(1., 1., 1.));

    // projections
    float va = dot(ga, w - vec3(0., 0., 0.));
    float vb = dot(gb, w - vec3(1., 0., 0.));
    float vc = dot(gc, w - vec3(0., 1., 0.));
    float vd = dot(gd, w - vec3(1., 1., 0.));
    float ve = dot(ge, w - vec3(0., 0., 1.));
    float vf = dot(gf, w - vec3(1., 0., 1.));
    float vg = dot(gg, w - vec3(0., 1., 1.));
    float vh = dot(gh, w - vec3(1., 1., 1.));

    // interpolation
    float gNoise = va + u.x * (vb - va) +
                   u.y * (vc - va) +
                   u.z * (ve - va) +
                   u.x * u.y * (va - vb - vc + vd) +
                   u.y * u.z * (va - vc - ve + vg) +
                   u.z * u.x * (va - vb - ve + vf) +
                   u.x * u.y * u.z * (-va + vb + vc - vd + ve - vf - vg + vh);

    return 2. * gNoise;
}

// warp uvs for the crt effect
vec2 crt(vec2 uv)
{
    float tht  = atan(uv.y, uv.x);
    float r = length(uv);
    r /= (1. - .1 * r * r);
    uv.x = r * cos(tht);
    uv.y = r * sin(tht);
    return .5 * (uv + 1.);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    float t = iTime;

    float glitchAmount = 0.0;

    float displayNoise = 0.;
    vec3 col = vec3(0.);

    // TWEAK: Chromatic Aberration
    vec2 eps = vec2(2. / iResolution.x, 0.);
    vec2 st = vec2(0.);

    // analog distortion
    float y = uv.y * iResolution.y;

    // TWEAK: Base analog wobble
    float distortion = gnoise(vec3(0., y * .01, t * 500.)) * .02;
    distortion *= gnoise(vec3(0., y * .02, t * 250.)) * .01;

    ++displayNoise;

    // TWEAK: The sharp, rolling horizontal tears
    distortion += smoothstep(.9998, 1., sin((uv.y + t * 1.6) * 2.)) * .005;
    distortion -= smoothstep(.9998, 1., sin((uv.y + t) * 2.)) * .005;

    st = uv + vec2(distortion, 0.);

    // sample textures for RGB
    col.r += textureLod(iChannel0, st + eps + distortion, 0.).r;
    col.g += textureLod(iChannel0, st, 0.).g;
    col.b += textureLod(iChannel0, st - eps - distortion, 0.).b;

    // FIX: Sample the original alpha (transparency) channel from Ghostty
    float alpha = textureLod(iChannel0, st, 0.).a;

    // white noise + scanlines
    displayNoise = 0.2 * clamp(displayNoise, 0., 1.);

    // TWEAK: Static noise and scanlines intensity
    col += (.05 + .65 * glitchAmount) * (hash33(vec3(fragCoord, mod(float(iFrame), 1000.))).r) * displayNoise;
    col -= (.10 + .75 * glitchAmount) * (sin(4. * t + uv.y * iResolution.y * 1.75)) * displayNoise;

    // FIX: Use the sampled alpha instead of a hardcoded 1.0
    fragColor = vec4(col, alpha);
}