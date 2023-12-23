#[repr(C)]
#[derive(Debug, Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub struct Vec2 {
    pub x: f32,
    pub y: f32,
}

impl Vec2 {
    pub fn new(x: f32, y: f32) -> Self {
        Self { x, y }
    }

    pub fn zero() -> Self {
        Self { x: 0.0, y: 0.0 }
    }
}

#[repr(C)]
#[derive(Debug, Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub struct Viewport {
    center: Vec2,
    size: Vec2,
}

impl Viewport {
    pub fn new() -> Self {
        Self {
            center: Vec2::zero(),
            size: Vec2::new(2.0, 2.0),
        }
    }

    pub fn zoom(&mut self, zoom: f32) {
        self.size.x *= zoom;
        self.size.y *= zoom;
    }

    pub fn move_by_screen_proportion(&mut self, px: f32, py: f32) {
        let distance_x = (self.size.x / 2.0) * px;
        let distance_y = (self.size.y / 2.0) * py;

        self.center.x += distance_x;
        self.center.y += distance_y;
    }
}