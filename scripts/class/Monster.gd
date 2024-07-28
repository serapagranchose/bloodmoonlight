extends "res://scripts/class/Entity.gd"

class_name Monster

func _ready():
	health.update_base(10)
	#health.update_modifier((cycle.get_cycle_number()/10 +1))
	current_health = 10 #* (cycle.get_cycle_number()/10 +1)
	defense.update_base(5)
	#defense.update_modifier((cycle.get_cycle_number()/10 +1))
	attack.update_base(5,)
	#attack.update_modifier((cycle.get_cycle_number()/10 +1))
	movementSpeed.update_base(100)
	print("Monster health:", health.value)
