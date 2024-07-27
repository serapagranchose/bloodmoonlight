extends "res://scripts/class/Player.gd"


const SPEED = 120.0
const JUMP_VELOCITY = -400.0

enum PlayerDirection {
	down,
	left,
	right,
	up
}

var _direction: PlayerDirection = PlayerDirection.down
var _directions: Array = []
@onready var _animated_sprite = $AnimatedSprite2D



func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		launch_attack()
		
	var input_direction = Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")

	velocity = input_direction * SPEED
	set_player_animation()
	move_and_slide()
	

func launch_attack():
	const attack = preload("res://scenes/BasicAttack.tscn")
	var mouse_position = get_global_mouse_position()
	var r = 12
	var h =  $Center.global_position[0]
	var k =  $Center.global_position[1]
	var x1 = mouse_position[0]
	var y1 = mouse_position[1]
	
	var t = 12 / sqrt((x1 - h) ** 2 + (y1 - k) ** 2)
	var attack_position = Vector2(h + 12 / sqrt((x1 - h) ** 2 + (y1 - k) ** 2) * (x1 - h), k + 12 / sqrt((x1 - h) ** 2 + (y1 - k) ** 2) * (y1 - k))

	var attack_direction = (mouse_position - $Center.global_position)
	var new_attack = attack.instantiate()
	new_attack.position = to_local(attack_position)
	new_attack.rotation = (attack_direction.angle())

	add_child(new_attack)
	print("REAL Attack position: ", new_attack.global_position)

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
