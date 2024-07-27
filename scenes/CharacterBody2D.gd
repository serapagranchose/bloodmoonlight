extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -400.0

enum PlayerDirection {
	down,
	left,
	right,
	up
}

var leftPressed = false
var _direction: PlayerDirection = PlayerDirection.down
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	set_player_animation()
	move_and_slide()
	
func set_player_animation():
	if (Input.is_action_pressed("ui_left")):
		print("Input left")
		_direction = PlayerDirection.left
		_animated_sprite.play("run_left")
	elif (Input.is_action_pressed("ui_right")):
		print("Input right")
		_direction = PlayerDirection.right
		_animated_sprite.play("run_right")
	elif (Input.is_action_pressed("ui_up")):
		print("Input up")
		_direction = PlayerDirection.up
		_animated_sprite.play("run_up")
	elif (Input.is_action_pressed("ui_down")):
		print("Input down")
		_direction = PlayerDirection.down
		_animated_sprite.play("run_down")
	elif (!_animated_sprite.is_playing() || (!Input.is_anything_pressed() && _animated_sprite.get_animation() != get_idle_animation(_direction) )):
		print("Change idle animation")
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
