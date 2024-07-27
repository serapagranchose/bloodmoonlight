extends CharacterBody2D

class_name Entity

var health
var defense
var attack
var movementSpeed

func _init(
	health = 20,
	defense = 5,
	attack = 5,
	movementSpeed = 100,
	healthModifier = 1.0,
	defenseModifier = 1.0,
	attackModifier = 1.0,
	movementSpeedModifier = 1.0,
	):
	health = Stat.new(20)
	defense = Stat.new(5)
	attack = Stat.new(5)
	movementSpeed = Stat.new(100)

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
