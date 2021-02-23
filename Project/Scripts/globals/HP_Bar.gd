extends Node2D

onready var screen_size = get_viewport_rect().size

func _process(delta):
	update()

func _draw():
	var Player = GLOBAL.PlayerPref
	draw_rect(Rect2(screen_size.x/2*-1+self.position.x, screen_size.y/2*-1+self.position.y, screen_size.x-2, 50) , Color(100,100,100), true)
	pass
