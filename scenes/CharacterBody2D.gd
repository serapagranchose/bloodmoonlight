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
var _directions: Array = []
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):

	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	print(input_direction)
	velocity = input_direction * SPEED
	set_player_animation()
	move_and_slide()
	
func set_player_animation():
	if (Input.is_action_pressed("ui_left") && _direction != PlayerDirection.left):
		print("Input left")
		_directions.push_front(PlayerDirection.left)
		_direction = PlayerDirection.left
		_animated_sprite.play("run_left")
	elif (Input.is_action_pressed("ui_right") && _direction != PlayerDirection.right):
		print("Input right")
		_directions.push_front(PlayerDirection.right)
		_direction = PlayerDirection.right
		_animated_sprite.play("run_right")
	elif (Input.is_action_pressed("ui_up") && _direction != PlayerDirection.up):
		print("Input up")
		_directions.push_front(PlayerDirection.up)
		_direction = PlayerDirection.up
		_animated_sprite.play("run_up")
	elif (Input.is_action_pressed("ui_down") && _direction != PlayerDirection.down):
		print("Input down")
		_directions.push_front(PlayerDirection.down)
		_direction = PlayerDirection.down
		_animated_sprite.play("run_down")
	elif (!_animated_sprite.is_playing() || (!Input.is_anything_pressed() && _animated_sprite.get_animation() != get_idle_animation(_direction) )):
		print("Change idle animation")
		_animated_sprite.play(get_idle_animation(_direction))
	if (_directions.size() > 5):
		_directions.pop_back()

func get_idle_animation(direction: PlayerDirection) -> String:
	var idle_animation = ""
	match direction:
		PlayerDirection.left: idle_animation = "idle_left"
		PlayerDirection.right: idle_animation = "idle_right"
		PlayerDirection.up: idle_animation = "idle_up"
		PlayerDirection.down: idle_animation = "idle_down"
		_: "None"
	return idle_animation

func get_animation_priority() -> String:
	var direction_count = {}
	var highest_direction = null
	var highest_count = 0
	for direction in _directions:
		if (direction_count.find_key(direction)):
			direction_count[direction] += 1
		else:
			direction_count[direction] = 0
	direction_count.keys().sort_custom(func(x: String, y: String) -> bool: return direction_count[x] > direction_count[y])
	if (direction_count.size() > 0):
		highest_direction = direction_count.keys()[0]
	else:
		highest_direction = "None"
	return get_idle_animation(highest_direction as PlayerDirection)
