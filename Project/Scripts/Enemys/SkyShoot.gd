extends KinematicBody2D

func _process(delta):
	Moving(delta)
func _ready():
	$AnimPlayer.play("ready")

func AnimPlayer_finished(anim_name):
	if anim_name == "ready":
		$AnimPlayer.play("Shot")
		speed=0
	if anim_name == "Shot":
		$AnimPlayer.play("end")
	if anim_name == "end":
		EENEMYOBSERVER.enemyPower-=50
		queue_free()

func AddPower() -> int:
	return 50
	
var speed = 300

func Moving(delta):
	var MoveVec = GLOBAL.PlayerPref.global_position - global_position
	MoveVec = MoveVec.normalized()
	move_and_slide(MoveVec*speed)
