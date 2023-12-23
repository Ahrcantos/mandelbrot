struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) fragmentPosition: vec2<f32>,
};

@vertex
fn vs_main(
    @builtin(vertex_index) vertex_index: u32,
) -> VertexOutput {
    var out: VertexOutput;
    var positions: array<vec2<f32>, 4> = array<vec2<f32>, 4>(
        vec2<f32>(1.0, -1.0),
        vec2<f32>(1.0, 1.0),
        vec2<f32>(-1.0, -1.0),
        vec2<f32>(-1.0, 1.0),
    );

    let position2d: vec2<f32> = positions[vertex_index];
    out.clip_position = vec4<f32>(position2d, 0.0, 1.0);
    out.fragmentPosition = position2d;
    return out;
}

struct FragmentOutput {
    @location(0) color: vec4<f32>,
}

struct Viewport {
    center: vec2<f32>,
    size: vec2<f32>,
}

@group(0) @binding(0)
var<uniform> viewport: Viewport;

const colors: array<vec4<f32>, 1> = array<vec4<f32>, 1>(
    vec4<f32>(1.0, 0.0, 0.0, 1.0),
);

@fragment
fn fs_main(in: VertexOutput) -> FragmentOutput {
    var out: FragmentOutput;
    out.color = mandlebrot((in.fragmentPosition * viewport.size) + viewport.center);
    return out;
}

fn mandlebrot(coords: vec2<f32>) -> vec4<f32> {
    var z: vec2<f32> = vec2<f32>(0.0, 0.0);

    for(var i: i32; i < 1000; i++) {
        z = vec2<f32>(pow(z.x, 2.0) - pow(z.y, 2.0), 2.0 * z.x * z.y) + coords;

        if length(z) > 2.0 {
            return vec4<f32>(1.0 * ( f32(i) / 1000.0), 1.0 * ( f32(i) / 700.0), 1.0 * ( f32(i) / 500.0), 1.0);
        }
    }
    return vec4<f32>(0.0, 0.0, 0.0, 1.0);
}