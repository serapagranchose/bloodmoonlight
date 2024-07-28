extends "res://scripts/class/Entity.gd"

class_name Monster

func _ready():
	var cycle = $CanvasModulate
	var modifier = 1
	if (cycle != null):
		modifier = cycle.get_cycle_number()/10 +1
	health.update_base(10)
	health.update_modifier(modifier)
	current_health = 10 * modifier
	defense.update_base(5)
	defense.update_modifier(modifier)
	attack.update_base(5)
	attack.update_modifier(modifier)
	movementSpeed.update_base(100)
