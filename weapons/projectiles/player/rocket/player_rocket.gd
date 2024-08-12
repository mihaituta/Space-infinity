class_name PlayerRocket
extends Projectile

@onready var player_rocket: Node2D = $"."
@onready var rocket_timer: Timer = $RocketTimer
@onready var destroy_spawner_component: SpawnerComponent = $DestroySpawnerComponent

var _target = null;
@export var max_speed = 250;
#var velocity = Vector2.ZERO
#var acceleration = Vector2.ZERO
#const STEER_FORCE = 150
var current_velocity = Vector2.ZERO
var previous_velocity = Vector2.ZERO
var change
var drag = 0.1
#var drag_factor: float = 0.08:
	#get:
		#return drag_factor
	#set(value):
		#drag_factor = value

func _ready() -> void:
	super();
	current_velocity = max_speed * Vector2.UP.rotated(rotation)
	previous_velocity = max_speed
	look_at(Vector2.UP)
#func seek():
	#var steer = Vector2.UP
	#if _target:
		#var desired = (_target.position - position).normalized() * max_speed
		#steer = (desired - velocity).normalized() * STEER_FORCE
	#return steer
	
func _physics_process(delta: float) -> void:
	
	previous_velocity = current_velocity
	
	if _target == null:
		#enemy_detector.set_deferred("monitoring",true);
		#position += max_speed * Vector2.UP.rotated(rotation).normalized() * delta;
		#position += max_speed *  delta;
		change = (previous_velocity - current_velocity) * drag
		previous_velocity+= change
		position += previous_velocity * delta
		return
	
	var direction := Vector2.UP.rotated(rotation).normalized()

	if _target:
		direction = global_position.direction_to(_target.global_position)
	
	var desired_velocity : Vector2 = direction * max_speed
	change = (desired_velocity - current_velocity) * drag
	current_velocity += change
	#position += current_velocity * delta
	
	#look_at(_target.global_position);
	
	#look_at(current_velocity + global_position);

	
	if _target:
		rotation = lerp_angle(rotation, global_position.angle_to_point(_target.global_position + Vector2(0,-10)), 0.08)
		position = position.move_toward(_target.global_position, max_speed *  delta);
	
#func set_drag_factor(new_value: float) -> void:
	#drag_factor = clamp(new_value, 0.01, 0.1)

#func _on_enemy_detector_area_entered(area: Area2D) -> void:
	#_target = area.get_parent();
	#enemy_detector.set_deferred("monitoring",false);


#func _on_rocket_timer_timeout() -> void:
	#destroy_spawner_component.spawn()
	#queue_free()
