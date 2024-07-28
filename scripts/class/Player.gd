extends "res://scripts/class/Entity.gd"

class_name Player

const attack_scene = preload("res://scenes/BasicAttack.tscn")

var gold: Stat
var attackScale: Stat
var attackCooldown: Stat
var attackRange: Stat

var can_attack = true

func _ready():
	super._ready()
	gold = Stat.new(0)
	attackScale = Stat.new(Vector2(1,1), 1)
	attackCooldown = Stat.new(1.5, 0)

func launch_attack():
	if !can_attack:
		return
	var mouse_position = get_global_mouse_position()
	var r = 12
	var h =  $Center.global_position[0]
	var k =  $Center.global_position[1]
	var x1 = mouse_position[0]
	var y1 = mouse_position[1]
	
	var t = r / sqrt((x1 - h) ** 2 + (y1 - k) ** 2)
	var attack_position = Vector2(h + r / sqrt((x1 - h) ** 2 + (y1 - k) ** 2) * (x1 - h), k + r / sqrt((x1 - h) ** 2 + (y1 - k) ** 2) * (y1 - k))

	var attack_direction = (mouse_position - $Center.global_position)
	var new_attack = attack_scene.instantiate()
	new_attack.scale = attackScale.value	
	new_attack.position = to_local(attack_position)
	new_attack.rotation = (attack_direction.angle())
	can_attack = false
	new_attack.damage = attack.value
	get_tree().create_timer(attackCooldown.value).timeout.connect(func(): can_attack = true)	
	add_child(new_attack)
	
