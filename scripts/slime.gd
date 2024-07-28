extends "res://scripts/class/Monster.gd"

const SPEED = 100.0

@onready var player = get_node("/root/game/Player")
@onready var game = get_node("/root/game")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if game.is_night:
		velocity = direction * SPEED
	else:
		velocity = -direction * SPEED
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if !game.is_night:
		game.ennemy_nb -= 1
		self.queue_free()
