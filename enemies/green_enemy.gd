class_name GreenEnemy;
extends Enemy
@onready var states: Node = $States
@onready var move_side_component: MoveComponent = %MoveSideComponent
@onready var move_side_state: TimedStateComponent = %MoveSideState
@onready var fire_rockets_state: StateComponent = %FireRocketsState
@onready var rockets_spawner_component: SpawnerComponent = %RocketsSpawnerComponent
@onready var pause_state: TimedStateComponent = %PauseState
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rockets_markers: Node2D = $RocketsMarkers


func _ready() -> void:
	super(); #calls Enemy (parent) class's _ready() function
	
	for state in states.get_children():
		state = state as StateComponent; #for auto-complete
		state.disable();

	move_side_component.velocity.x = [-20, 20].pick_random();

	#move_down_state.state_finished.connect(move_side_state.enable);
	move_side_state.state_finished.connect(func():
			fire_rockets_state.enable();
			start_fire_bullet_animation();
			fire_rockets_state.disable();
			fire_rockets_state.state_finished.emit();
	);
	fire_rockets_state.state_finished.connect(pause_state.enable);
	pause_state.state_finished.connect(move_side_state.enable);
	move_side_state.enable()
	
	#pause_state.state_finished.connect(move_down_state.enable);
	#move_down_state.enable();
	
func fire_rocket(muzleIndex: int) -> void:
	#spawnRocket(enemy_list[muzleIndex % enemy_list.size()],rockets_markers.get_child(muzleIndex).global_position);
	rockets_spawner_component.spawn(rockets_markers.get_child(muzleIndex).global_position);
	
func start_fire_bullet_animation() -> void:
	animation_player.play("fire_rockets");

func start_idle_animation() -> void:
	animation_player.play("idle");
