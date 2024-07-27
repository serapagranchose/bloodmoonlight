extends Area2D

var damage = 0

func _physics_process(delta):
	if !$AnimatedSprite2D.is_playing():
		queue_free()
	


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage()
	pass # Replace with function body.
