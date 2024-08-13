extends Skill
class_name LaserSkill

func _init(target):
	cooldown = 4.0;
	spell_name = "start_fire_laser_animation";
	texture = preload("res://assets/PickupsPack/Weapons/Aseprite/laserIcon.png");
	
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.start_fire_laser_animation()
