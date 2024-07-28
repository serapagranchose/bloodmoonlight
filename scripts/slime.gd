extends "res://scripts/class/Monster.gd"

const SPEED = 100.0
var touched_entity = []
@onready var player = get_node("/root/game/Player")
@onready var game = get_node("/root/game")
@onready var _health_bar = $HealthBar.get_node("ProgressBar")


func _physics_process(delta):
	if (_health_bar.value != current_health):
		_health_bar.value = current_health
	if (_health_bar.max_value != health.value):
		_health_bar.set_max(health.value)
	if (is_instance_valid(player)):
		var direction = global_position.direction_to(player.global_position)
		if game.is_night:
			velocity = direction * movementSpeed.value
		else:
			velocity = -direction * movementSpeed.value
	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if !game.is_night:
		game.ennemy_nb -= 1
		self.queue_free()


func _on_area_2d_body_entered(body):
	if (body in touched_entity):
		return
	
	if body.has_method("take_damage") && "player" in body:
		print("ATTACK HIM")
		body.take_damage(attack.value)
		touched_entity.append(body)
	pass # Replace with function body.

