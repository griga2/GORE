extends Timer

var CheckForNamberCucle = true

func _ready():
	pass


func _on_LatersTimer_timeout():
	if CheckForNamberCucle==true:
		$Laters.visible=true
		$Laters.play("LatersAnim")
		pass
	else:
		$Laters2.visible=true
		$Larers2.play("LatersAnim")
		pass





func _on_Laters_animation_finished():
	if $Laters.is_playing()!=true:
		$Laters.stop()
		CheckForNamberCucle=false
		start()
	pass
	
func _on_Laters2_animation_finished():
	if $Laters.is_playing()!=true:
		$Laters2.stop()
		CheckForNamberCucle=true
		start()
	pass
