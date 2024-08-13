extends Skill
class_name RocketsSkill

func _init(target):
	cooldown = 2.0;
	spell_name = "start_fire_rockets_animation";
	texture = preload("res://assets/PickupsPack/Weapons/Aseprite/rocketsIcon.png");
	
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.start_fire_rockets_animation()
