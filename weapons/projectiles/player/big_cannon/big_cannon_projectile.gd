class_name BigCannonProjectile
extends Projectile

@onready var big_explosion: HitboxComponent = $BigExplosion

func _ready() -> void:
	#super()
	scale_component.tween_scale();
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free);
	hitbox_component.hit_hurtbox.connect(explode.unbind(1))

func explode() -> void:
	big_explosion.monitoring = true;
	await get_tree().create_timer(0.1).timeout;
	queue_free()

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Key_4")):
		explode()
