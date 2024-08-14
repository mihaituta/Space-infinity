extends Node
class_name PowerUpDroppableComponent

@export var SpawnPoint: Node2D
@export var Stats: StatsComponent
@export var PowerUps: Array[PackedScene]
@export var PowerUpsCooldown: Array[int]

var stop_spawn = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	
	Stats.no_health.connect(func():
		for power_up in PowerUps:
			var chance = randi_range(0,100);
			print(power_up.get_class() + " " + str(chance))
			if chance <= PowerUpsCooldown[PowerUps.find(power_up)] &&  !stop_spawn:
				spawn(power_up, SpawnPoint.global_position)
				stop_spawn = true;
		print("")
		stop_spawn = false;
	)

func spawn(scene, global_spawn_position, parent: Node = get_tree().current_scene):
	# Instance the scene 
	var instance = scene.instantiate()
	# Add it as a child of the parent
	#SpawnPoint.add_child(instance)
	parent.add_child(instance)
	# Update the global position of the instance.
	# (This must be done after adding it as a child)
	instance.global_position = global_spawn_position
	# Return the instance in case we want to perform any other operations
	# on it after instancing it.
	return instance

