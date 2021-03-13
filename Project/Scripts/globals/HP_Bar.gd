extends Node2D

onready var screen_size = get_viewport_rect().size

func _process(delta):
	update()

func _draw():
	var Player = GLOBAL.PlayerPref
	draw_rect(Rect2(screen_size.x/2*-1+self.position.x, screen_size.y/2*-1+self.position.y, (screen_size.x-2)/100*GLOBAL.PlayerHP, 7) , Color(100,100,100), true)
#	for i in range(0, screen_size.x/10):
#		for j in range(1,30):
#			draw_rect(Rect2(screen_size.x/2*-1+self.position.x+(i*10), screen_size.y/2*-1+self.position.y, 10, 50), Color (1,1,j))
	pass



