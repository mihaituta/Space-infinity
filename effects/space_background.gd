extends ParallaxBackground;
@onready var space_layer: ParallaxLayer = %SpaceLayer;
@onready var far_stars_layer: ParallaxLayer = %FarStarsLayer;
@onready var close_stars_layer: ParallaxLayer = %CloseStarsLayer;
@onready var bg: ParallaxLayer = $BG;

func _process(delta: float) -> void:
	bg.motion_offset.y += 4 * delta;	
	space_layer.motion_offset.y += 4 * delta;
	far_stars_layer.motion_offset.y += 8 * delta;
	close_stars_layer.motion_offset.y += 16 * delta;
