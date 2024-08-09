class_name Enemy
extends Node2D
@onready var animated_sprite_2d: = $AnimatedSprite2D
@onready var stats_component: = $StatsComponent
@onready var move_component: = $MoveComponent
@onready var scale_component: = $ScaleComponent
@onready var visible_on_screen_notifier_2d: = $VisibleOnScreenNotifier2D
@onready var flash_component: = $FlashComponent
@onready var shake_component: = $ShakeComponent
@onready var hitbox_component: = $HitboxComponent
@onready var hurtbox_component: = $HurtboxComponent
@onready var destroyed_component: = $DestroyedComponent
@onready var score_component:  = $ScoreComponent

func _ready() -> void:
	stats_component.no_health.connect(func():
		score_component.adjust_score()
	)
	
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free);
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		scale_component.tween_scale();
		flash_component.flash();
		shake_component.tween_shake();
	);
	
	stats_component.no_health.connect(queue_free);
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1));
