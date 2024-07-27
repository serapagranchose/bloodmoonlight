extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum PlayerDirection {
	down,
	left,
	right,
	up
}

var direction: PlayerDirection = PlayerDirection.down

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	Input.is_anything_pressed()
	if (Input.is_action_pressed("ui_left") && direction != PlayerDirection.left):
		print("Input left")
		direction = PlayerDirection.left
		_animated_sprite.play("run_left")
	elif (Input.is_key_pressed(KEY_D) && direction != PlayerDirection.right):
		print("Input right")
		direction = PlayerDirection.right
		_animated_sprite.play("run_right")
	elif (Input.is_key_pressed(KEY_Z) && direction != PlayerDirection.up):
		print("Input up")
		direction = PlayerDirection.up
		_animated_sprite.play("run_up")
	elif (Input.is_key_pressed(KEY_S) && direction != PlayerDirection.down):
		print("Input down")
		direction = PlayerDirection.down
		_animated_sprite.play("run_down")
	elif (!_animated_sprite.is_playing() || (!Input.is_anything_pressed() && _animated_sprite.get_animation() != get_idle_animation() )):
		print("Change idle animation")
		_animated_sprite.play(get_idle_animation())
	
func get_idle_animation() -> String:
	var idle_animation = ""
	match direction:
		PlayerDirection.left: idle_animation = "idle_left"
		PlayerDirection.right: idle_animation = "idle_right"
		PlayerDirection.up: idle_animation = "idle_up"
		PlayerDirection.down: idle_animation = "idle_down"

	return idle_animation
