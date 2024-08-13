extends Skill
class_name BigCannonSkill

func _init(target):
	cooldown = 10.0;
	spell_name = "start_fire_big_cannon_animation";
	texture = preload("res://assets/PickupsPack/Weapons/Aseprite/bigcanonIcon.png");
	
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.start_fire_big_cannon_animation()



