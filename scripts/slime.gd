extends CharacterBody2D

const SPEED = 100.0

@onready var player = get_node("/root/game/Player")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	print("Onch", player.global_position)
	velocity = direction * SPEED
	move_and_slide()
