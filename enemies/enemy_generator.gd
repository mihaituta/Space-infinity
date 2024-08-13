extends Node2D;

@export var RedEnemeyScene: PackedScene
@export var GreenEnemeyScene: PackedScene
@export var BlueEnemyScene: PackedScene

@export var game_stats: GameStats

var margin = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width");

@onready var spawner_component: = $SpawnerComponent;
@onready var red_enemy_spawn_timer: Timer = $RedEnemySpawnTimer
@onready var green_enemy_spawn_timer: Timer = $GreenEnemySpawnTimer
@onready var blue_enemy_spawn_timer: Timer = $BlueEnemySpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	red_enemy_spawn_timer.timeout.connect(handle_spawn.bind(RedEnemeyScene, red_enemy_spawn_timer));
	blue_enemy_spawn_timer.timeout.connect(handle_spawn.bind(BlueEnemyScene, blue_enemy_spawn_timer));
	#green_enemy_spawn_timer.timeout.connect(handle_spawn.bind(GreenEnemeyScene, green_enemy_spawn_timer, 5.0));
	#blue_enemy_spawn_timer.timeout.connect(handle_spawn.bind(BlueEnemyScene, blue_enemy_spawn_timer, 10.0));
	
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 0:
			green_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT;
		if new_score > 0:
			blue_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT;
	);
	
func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = enemy_scene;
	spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), -16));
	var spawn_rate = time_offset / (0.5 + (game_stats.score * 0.01))
	
	timer.start(spawn_rate + randf_range(0.25, 0.5));
