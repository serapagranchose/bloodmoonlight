extends Area2D


func _physics_process(delta):
	if !$AnimatedSprite2D.is_playing():
		queue_free()
	
