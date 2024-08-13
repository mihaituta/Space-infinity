extends HBoxContainer

var slots: Array

func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1);

	#Testing
	slots[0].skill = AutoCannonsTurboSkill.new(slots[0]);
	slots[1].skill = RocketsSkill.new(slots[1]);
	slots[2].skill = LaserSkill.new(slots[2]);
	slots[3].skill = BigCannonSkill.new(slots[3]);
	slots[4].skill = ShieldSkill.new(slots[4]);
