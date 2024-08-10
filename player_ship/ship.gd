extends Node2D
@onready var auto_cannons_fire_rate_timer: = $AutoCannonsFireRateTimer
@onready var scale_component: = $ScaleComponent;
@onready var move_component: = $MoveComponent;
@onready var ship_sprite_2d: = $Anchor/ShipSprite2D;
@onready var flame_animated_sprite_2d: = $Anchor/FlameAnimatedSprite2D;
@onready var audio_stream_player: = $VariablePitchAudioStreamPlayer;
@onready var cannons_spawner: = $CannonsSpawner
@onready var rockets_spawner: = $RocketsSpawner
@onready var rockets_markers: = $RocketsMarkers
@onready var rocket_fire_rate_timer: = $RocketFireRateTimer
@onready var animation_player: = $AnimationPlayer
@onready var cannons_markers: = $CannonsMarkers
@onready var big_cannon_spawner: SpawnerComponent = $BigCannonSpawner
@onready var big_cannon_marker: = $BigCannonMarker;

func _ready() -> void:
	#auto_cannons_fire_rate_timer.timeout.connect(start_fire_autocannons_animation);
	start_fire_autocannons_animation();
	#rocket_fire_rate_timer.timeout.connect(start_fire_rockets_animation);
	#rocket_fire_rate_timer.timeout.connect(start_fire_big_cannon_animation);
	
func start_fire_autocannons_animation() -> void:
	animation_player.play("fire_autocannons");

func fire_autocannons(cannonIndex: int) -> void:
	audio_stream_player.play_with_variance();
	for cannon in cannons_markers.get_children():
		cannons_spawner.spawn(cannon.global_position);
	
	scale_component.tween_scale();

func start_fire_rockets_animation() -> void:
	animation_player.play("fire_rockets");
	#for rocket in rockets_markers.get_children():
		#rockets_spawner.spawn(rocket.global_position);
		#await get_tree().create_timer(0.1).timeout;

func fire_rocket(muzleIndex: int) -> void:
	rockets_spawner.spawn(rockets_markers.get_child(muzleIndex).global_position);

func start_fire_big_cannon_animation() -> void:
	animation_player.play("fire_big_cannon");

func fire_big_cannon() -> void:
	big_cannon_spawner.spawn(big_cannon_marker.global_position);

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Key_1"):
		start_fire_autocannons_animation();
	elif Input.is_action_just_pressed("Key_2"):
		start_fire_rockets_animation();
	elif Input.is_action_just_pressed("Key_3"):
		start_fire_big_cannon_animation();
	
	animate_the_ship();
	
func animate_the_ship() -> void:
	#if (move_component.velocity.x < 0):
		#animated_sprite_2d.play("bank_left");
		#flame_animated_sprite_2d.play("bank_left");
	#elif (move_component.velocity.x > 0):
		#animated_sprite_2d.play("bank_right");
		#flame_animated_sprite_2d.play("bank_right");
	#else:
		ship_sprite_2d.play("center");
		flame_animated_sprite_2d.play("center");


