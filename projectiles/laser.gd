extends Node2D

@onready var visible_on_screen_notifier_2d: = $VisibleOnScreenNotifier2D;
@onready var scale_component: = $ScaleComponent;
@onready var flash_component: = $FlashComponent;
@onready var hitbox_component: = $HitboxComponent

func _ready() -> void:
	scale_component.tween_scale();
	flash_component.flash();
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free);
	
	#need to call .unbind(1) because hit_hurtbox expects 1 argument, but queue_free doesn't have any arguments and we need to unbind it
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
