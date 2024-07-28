extends Area2D

var damage = 0

func _physics_process(delta):
	if !$AnimatedSprite2D.is_playing():
		queue_free()
	

func _on_body_entered(body):
	print(body)
	if body.has_method("take_damage"):
		print("ATTACK HIM")
		body.take_damage(damage)
	pass # Replace with function body.
