extends Node2D
@onready var auto_cannons_fire_rate_timer: = $AutoCannonsFireRateTimer
@onready var scale_component: = $ScaleComponent;
@onready var move_component: = $MoveComponent;
@onready var audio_stream_player: = $VariablePitchAudioStreamPlayer;
@onready var cannons_spawner: = $CannonsSpawner
@onready var rockets_spawner: = $RocketsSpawner
@onready var rockets_markers: = $RocketsMarkers
@onready var rocket_fire_rate_timer: = $RocketFireRateTimer
@onready var animation_player: = $AnimationPlayer
@onready var cannons_markers: = $CannonsMarkers
@onready var big_cannon_spawner: SpawnerComponent = $BigCannonSpawner
@onready var big_cannon_marker: = $BigCannonMarker;
@onready var enemy_detector: Area2D = $Node/EnemyDetector
@onready var laser_marker: Marker2D = $Anchor/LaserMarker
@onready var shield: AnimatedSprite2D = $Anchor/Shield
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

const PLAYER_ROCKET = preload("res://weapons/projectiles/player/rocket/player_rocket.tscn")
const LASER = preload("res://weapons/projectiles/player/laser/laser.tscn")

var enemy_list = [];

func _ready() -> void:
	start_fire_autocannons_animation();
	
#DEFAULT SKILL
func start_fire_autocannons_animation() -> void:
	animation_player.speed_scale = 2;
	animation_player.play("fire_autocannons");

func fire_autocannons() -> void:
	audio_stream_player.play_with_variance();
	for cannon in cannons_markers.get_children():
		cannons_spawner.spawn(cannon.global_position);
	
	scale_component.tween_scale();

#SKILL 1 TURBO CANNNONS
func start_autocannnos_turbo() -> void:
	animation_player.speed_scale = 4;
	await get_tree().create_timer(5).timeout;
	animation_player.speed_scale = 2;


#SKILL 2 ROCKETS
func start_fire_rockets_animation() -> void:
	enemy_list.clear()
	animation_player.play("fire_rockets");
	enemy_detector.monitoring = true;
	await get_tree().create_timer(0.2).timeout;
	
func spawnRocket(target, global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:
	var instance = PLAYER_ROCKET.instantiate()
	# Add it as a child of the parent
	parent.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	instance.global_position = global_spawn_position
	instance._target = target
	# Return the instance in case we want to perform any other operations
	# on it after instancing it.
	return instance

func fire_rocket(muzleIndex: int) -> void:
	if(enemy_list.size() > 0):
		spawnRocket(enemy_list[muzleIndex % enemy_list.size()],rockets_markers.get_child(muzleIndex).global_position);
	#rockets_spawner.spawn(rockets_markers.get_child(muzleIndex).global_position)
	
#SKILL 3 LASER
func start_fire_laser_animation() -> void:
	animation_player.play("fire_laser"); 
	var instance = LASER.instantiate()
	# Add it as a child of the parent
	laser_marker.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	instance.global_position = laser_marker.global_position
	
	#laser_spawn.process_mode = Node.PROCESS_MODE_INHERIT;
	await get_tree().create_timer(4).timeout;
	#laser_spawn.process_mode = Node.PROCESS_MODE_DISABLED;
	instance.queue_free()
	start_fire_autocannons_animation();
	
#SKILL 4 BIG CANNON
func start_fire_big_cannon_animation() -> void:
	animation_player.play("fire_big_cannon");

func fire_big_cannon() -> void:
	big_cannon_spawner.spawn(big_cannon_marker.global_position);

#SKILL 5 SHIELD
func start_shield_animation() -> void:
	shield.visible = true;
	shield.play("shield")
	hurtbox_component.is_invincible = true;
	await get_tree().create_timer(5).timeout;
	shield.visible = false;
	shield.stop()
	hurtbox_component.is_invincible = false;
	
func _on_enemy_detector_area_entered(area: Area2D) -> void:
	enemy_list.append(area.get_parent());
