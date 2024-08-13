class_name BlueEnemy
extends Enemy

@onready var states: Node = $States
@onready var move_down_state: = %MoveDownState;
@onready var move_side_state: = %MoveSideState;
@onready var pause_state: = %PauseState;
@onready var move_side_component: = %MoveSideComponent
@onready var projectile_spawner_component: = %ProjectileSpawnerComponent
@onready var fire_state: = %FireState
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bullet_muzzle: Marker2D = $BulletMuzzle


func _ready() -> void:
	super(); #calls Enemy (parent) class's _ready() function
	
	for state in states.get_children():
		state = state as StateComponent; #for auto-complete
		state.disable();

	move_side_component.velocity.x = [-20, 20].pick_random();

	move_down_state.state_finished.connect(move_side_state.enable);
	move_side_state.state_finished.connect(func():
		fire_state.enable();
		scale_component.create_tween();
		#projectile_spawner_component.spawn(global_position);
		start_fire_bullet_animation()
		fire_state.disable();
		fire_state.state_finished.emit();
	);
	fire_state.state_finished.connect(pause_state.enable);
	pause_state.state_finished.connect(move_down_state.enable);
	
	move_down_state.enable();

func start_fire_bullet_animation() -> void:
	animation_player.play("fire_bullet");

func fire_bullet() -> void:
	projectile_spawner_component.spawn(bullet_muzzle.global_position);
