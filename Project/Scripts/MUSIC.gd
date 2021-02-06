extends Node2D

func Play_music(name):
	get_node(name).play()
func Stop_music(name):
	get_node(name).stop()

func _ready():
	#Play_music("Intro1")
	#Stop_all()
	pass

func Stop_all():
	var all = get_tree().get_nodes_in_group("music_node")
	all.stop()

func _on_Rage1_finished():
	Play_music("Rage2")
 
 
 
