extends Node2D

@onready var left_muzzle: = $LeftMuzzle;
@onready var right_muzzle: = $RightMuzzle;
@onready var spawner_component: = $SpawnerComponent;
@onready var fire_rate_timer: = $FireRateTimer;
@onready var scale_component: = $ScaleComponent;
@onready var move_component: = $MoveComponent;
@onready var animated_sprite_2d: = $Anchor/AnimatedSprite2D;
@onready var flame_animated_sprite_2d: = $Anchor/FlameAnimatedSprite2D
@onready var audio_stream_player: VariablePitchAudioStreamPlayer = $VariablePitchAudioStreamPlayer

func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers);

func fire_lasers() -> void:
	audio_stream_player.play_with_variance();
	spawner_component.spawn(left_muzzle.global_position);
	spawner_component.spawn(right_muzzle.global_position);
	scale_component.tween_scale();

func _process(delta: float) -> void:
	animate_the_ship();
	
func animate_the_ship() -> void:
	if (move_component.velocity.x < 0):
		animated_sprite_2d.play("bank_left");
		flame_animated_sprite_2d.play("bank_left");
	elif (move_component.velocity.x > 0):
		animated_sprite_2d.play("bank_right");
		flame_animated_sprite_2d.play("bank_right");
	else:
		animated_sprite_2d.play("center");
		flame_animated_sprite_2d.play("center");
