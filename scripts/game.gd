extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var ui = $CanvasLayer/DayNightCycleUI

var is_merchant_there = true
var is_night = false
var ennemy_nb = 0
var ennemy_max = 10

func spawn_mob():
	var new_mob = preload("res://scenes/slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.add_to_group("ennemies")
	ennemy_nb += 1
	print(new_mob, " spawned!")

func cycle(day, hour, minute):
	if (hour >= 20 || hour <= 5):
		if (!is_night): is_night = true
		if (ennemy_nb < ennemy_max):
			spawn_mob()
		is_merchant_there = false
	else:
		if (is_night): is_night = false
		if (hour == 6 && !is_merchant_there):
			is_merchant_there = true
			ennemy_max += day * 5
			print("Ennemy max increased to ", ennemy_max, "!")

func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(ui.set_daytime)
