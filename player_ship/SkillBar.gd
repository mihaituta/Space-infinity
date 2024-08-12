extends HBoxContainer

var slots: Array

func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1);

	#Testing
	slots[0].skill = AutoCannonsTurboSkill.new(slots[0])
	slots[1].skill = RocketsSkill.new(slots[1])
