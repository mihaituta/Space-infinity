extends Enemy
class_name RedEnemy

@onready var projectile_spawner_component: = $ProjectileSpawnerComponent
@onready var bullet_marker_left: = $BulletMarkerLeft
@onready var bullet_marker_right: = $BulletMarkerRight
@onready var animation_player: = $AnimationPlayer
@onready var fire_bullets_audio_stream_player: = $FireBulletsAudioStreamPlayer

func _ready() -> void:
	super(); #calls Enemy (parent) class's _ready() function
	
func _on_fire_rate_timeout() -> void:
	animation_player.play("fire_bullets");
	
func start_fire_autocannons() -> void:
	fire_bullets_audio_stream_player.play_with_variance();
	projectile_spawner_component.spawn(bullet_marker_left.global_position);
	projectile_spawner_component.spawn(bullet_marker_right.global_position);

func start_idle_animation() -> void:
	animation_player.play("idle");
