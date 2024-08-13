class_name YellowEnemy;
extends Enemy

func _ready() -> void:
	super(); #calls Enemy (parent) class's _ready() function
	move_component.velocity.x = [-20,20].pick_random();
