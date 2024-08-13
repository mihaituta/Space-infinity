extends Skill
class_name ShieldSkill

func _init(target):
	cooldown = 5.0;
	spell_name = "start_shield_animation";
	texture = preload("res://assets/PickupsPack/Weapons/Aseprite/shieldIcon.png");
	
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.start_shield_animation()
