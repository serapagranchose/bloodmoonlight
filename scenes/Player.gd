extends "res://scripts/class/Player.gd"

const SPEED = 120.0
const JUMP_VELOCITY = -400.0

enum PlayerDirection {
	down,
	left,
	right,
	up
}

<<<<<<< HEAD:scenes/Player.gd

=======
>>>>>>> origin/main:scenes/CharacterBody2D.gd
var _direction: PlayerDirection = PlayerDirection.down
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		launch_attack()
		
	var input_direction = Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	velocity = input_direction * SPEED
	set_player_animation()
	move_and_slide()


func set_player_animation():
	if (Input.is_action_pressed("ui_left")):
		_direction = PlayerDirection.left
		_animated_sprite.play("run_left")
	elif (Input.is_action_pressed("ui_right")):
		_direction = PlayerDirection.right
		_animated_sprite.play("run_right")
	elif (Input.is_action_pressed("ui_up")):
		_direction = PlayerDirection.up
		_animated_sprite.play("run_up")
	elif (Input.is_action_pressed("ui_down")):
		_direction = PlayerDirection.down
		_animated_sprite.play("run_down")
	elif (!_animated_sprite.is_playing() || (!Input.is_anything_pressed() && _animated_sprite.get_animation() != get_idle_animation(_direction) )):
		_animated_sprite.play(get_idle_animation(_direction))

func get_idle_animation(direction: PlayerDirection) -> String:
	var idle_animation = ""
	match direction:
		PlayerDirection.left: idle_animation = "idle_left"
		PlayerDirection.right: idle_animation = "idle_right"
		PlayerDirection.up: idle_animation = "idle_up"
		PlayerDirection.down: idle_animation = "idle_down"
		_: "None"
	return idle_animation
