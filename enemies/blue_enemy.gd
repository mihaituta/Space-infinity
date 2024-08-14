class_name BlueEnemy
extends Enemy

@onready var states: Node = $States
@onready var move_down_state: = %MoveDownState;
@onready var move_side_state: = %MoveSideState;
@onready var pause_state: = %PauseState;
@onready var move_side_component: = %MoveSideComponent
@onready var projectile_spawner_component: = %ProjectileSpawnerComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bullet_muzzle: Marker2D = $BulletMuzzle
@onready var rockets_spawner_component: SpawnerComponent = %RocketsSpawnerComponent
@onready var fire_bullet_state: StateComponent = %FireBulletState
@onready var fire_rockets_state: StateComponent = %FireRocketsState
@onready var rocket_muzzle_left: Marker2D = $RocketMuzzleLeft
@onready var rocket_muzzle_right: Marker2D = $RocketMuzzleRight
@onready var fire_bullets_audio_stream_player: VariablePitchAudioStreamPlayer = $FireBulletsAudioStreamPlayer


func _ready() -> void:
	super(); #calls Enemy (parent) class's _ready() function
	
	for state in states.get_children():
		state = state as StateComponent; #for auto-complete
		state.disable();

	move_side_component.velocity.x = [-35, 35].pick_random();

	#move_down_state.state_finished.connect(move_side_state.enable);
	move_side_state.state_finished.connect(func():
		if (randi_range (0,1) == 0):
			fire_bullet_state.enable();
			start_fire_bullet_animation();
			fire_bullets_audio_stream_player.play_with_variance();
			fire_bullet_state.disable();
			fire_bullet_state.state_finished.emit();
		else:
			fire_rockets_state.enable();
			fire_rockets();
			fire_rockets_state.disable();
			fire_rockets_state.state_finished.emit();
	);
	fire_bullet_state.state_finished.connect(pause_state.enable);
	fire_rockets_state.state_finished.connect(pause_state.enable);
	pause_state.state_finished.connect(move_side_state.enable);
	move_side_state.enable();
	
	#pause_state.state_finished.connect(move_down_state.enable);
	#move_down_state.enable();
func start_fire_bullet_animation() -> void:
	animation_player.play("fire_bullet");

func fire_bullet() -> void:
	projectile_spawner_component.spawn(bullet_muzzle.global_position);

func fire_rockets() -> void:
	rockets_spawner_component.spawn(rocket_muzzle_left.global_position);
	rockets_spawner_component.spawn(rocket_muzzle_right.global_position);
