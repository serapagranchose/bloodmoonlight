extends Node2D

@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var ui = $CanvasLayer/DayNightCycleUI

var round = 0
var ennemy_nb = 0
var ennemy_max = 10

func spawn_mob():
	var new_mob = preload("res://scenes/slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_ennemy_spawn_timer_timeout():
	if (canvas_modulate.IS_NIGHT && ennemy_nb < ennemy_max):
		spawn_mob()
		ennemy_nb += 1

func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(ui.set_daytime)
