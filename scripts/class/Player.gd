extends "res://scripts/class/Entity.gd"

class_name Player

var gold: Stat
var attackScale: Stat
var attackSpeed: Stat
var attackRange: Stat

func _init():
	gold = Stat.new(0)
	attackScale = Stat.new(Vector2(1,1))
	attackSpeed = Stat.new(1.0)
