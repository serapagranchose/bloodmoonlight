extends CharacterBody2D

class_name Entity

var health: Stat
var current_health: int
var defense: Stat
var attack: Stat
var movementSpeed: Stat

func _ready():
	health = Stat.new(0)
	current_health = health.value
	defense = Stat.new(0)
	attack = Stat.new(0)
	movementSpeed = Stat.new(0)

	
func take_damage(damage: int):
	current_health -= damage * damage_reduction_multiplier()
	if (current_health <= 0):
		queue_free()

func damage_reduction_multiplier():
	return 1 - (0.80 / (1 + exp(-0.03 * (defense.value - 70))))
	
func heal(heal: int = health.value):
	current_health = clamp(current_health + heal, 0, health.value)
class Stat:
	var _base: Variant
	var _modifier: float
	
	func _init(base: Variant, modifier: float = 1.0):
		_base = base
		_modifier = modifier
	
	func get_base() -> Variant: return _base
	func update_base(value: Variant) -> void: _base += value
	
	func get_modifier() -> float: return _modifier
	func update_modifier(modifier: float) -> void: _modifier * modifier
	
	func _get(value_name: StringName) -> Variant:
		if value_name == "value":
			return _base * _modifier
		return null
