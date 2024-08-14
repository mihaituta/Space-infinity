extends Node2D
class_name PowerUp
@onready var visible_on_screen_notifier_2d: = $VisibleOnScreenNotifier2D
@onready var area_2d: Area2D = $Area2D
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free);
	#area_2d.area_entered.connect(queue_free.unbind(1))
	flash_component.flash()
	scale_component.tween_scale()
	shake_component.tween_shake()
