extends Skill
class_name AutoCannonsTurboSkill

func _init(target):
	cooldown = 5.0;
	spell_name = "start_autocannnos_turbo";
	texture = preload("res://assets/PickupsPack/Weapons/Aseprite/cannonsIcon.png");
	
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.start_autocannnos_turbo()
