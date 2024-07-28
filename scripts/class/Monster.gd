extends "res://scripts/class/Entity.gd"

class_name Monster


func _ready():
	health.update_base(100)
	current_health = 100
	defense.update_base(5)
	attack.update_base(5)
	movementSpeed.update_base(100)
	print("Monster health:", health.value)
