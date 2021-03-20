extends Node2D

func _process(delta):
		position += transform.y * -800 * delta


func _on_DeadTimer_timeout():
	queue_free()
