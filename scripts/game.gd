extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var ui = $CanvasLayer/DayNightCycleUI

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

func night(hour, minute):
	if (!is_night): is_night = true
	if (ennemy_nb < ennemy_max):
		spawn_mob()

func day(hour, minute):
	if (is_night): is_night = false

func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(ui.set_daytime)
