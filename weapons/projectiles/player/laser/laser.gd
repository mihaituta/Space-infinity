extends Node2D

@onready var timer: Timer = $Timer
@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
	#deactivate and activate monitoring to do damage every 0.5 sec
	timer.timeout.connect(func (): 
		hitbox_component.monitoring = !hitbox_component.monitoring
	)
