extends KinematicBody2D
var hands_script = load("res://Scripts/Hand_Script.gd") #ссылка класс руки
var player_hands = hands_script.new()#подключение класса руки
var MOVE_SPEED = 300 #250
var DASH_SPEED = 675 #500
var can_damage = true #можно ли нанести урон
onready var current_hand = $PBodyRight/PHand1
var ready = false
var mazafakaDaash = false #Дешит ли он?
var move_vect = Vector2()

func _ready():
	$DashDelayTimer.stop()
	GLOBAL.PlayerDead = false
	if GLOBAL.PlayerHaveGun == false:
		PlayerNoGun()
	else:PlayerUpGun()
	GLOBAL.PlayerPref = self

func PlayerNoGun():
	ready = false
	$PBodyLeft.hide()
	$PBodyRight.hide()
	$Player_no_gun.show()
	$PlayerAnim.play("ready")
	
func PlayerUpGun():
	ready = true
	GLOBAL.PlayerHaveGun = true
	$PBodyLeft.show()
	$PBodyRight.show()
	$Player_no_gun.hide()
	pass

func _process(delta):
	if GLOBAL.PlayerDead == false and ready == true:
		GLOBAL.PlayerPref = self
		
		if GLOBAL.PlayerHaveGun == true:
			Mouse_looking()

		if (mazafakaDaash==true):
			MovingDash(delta)
		else:
			Moving(delta)
			


var Dash_x = float(0)
var Dash_y = float(0)

func Moving(delta):
	move_vect = Vector2(0, 0)
	
	if Input.is_action_pressed("dash"): #Проверяет нажате пробелла и дешит
#		if mazafakaDaash != true:
		if $DashDelayTimer.is_stopped():
			mazafakaDaash=true
	
	if Input.is_action_pressed("move_up"):
		if (mazafakaDaash==true):
			Dash_y=-1 
		elif(mazafakaDaash==false):
			move_vect.y -=1
	if Input.is_action_pressed("move_down"):
		if (mazafakaDaash==true):
			Dash_y=1
		elif(mazafakaDaash==false):
			move_vect.y +=1
	if Input.is_action_pressed("move_right"):
		if (mazafakaDaash==true):
			Dash_x=1
		elif(mazafakaDaash==false):
			move_vect.x += 1
	if Input.is_action_pressed("move_left"):
		if (mazafakaDaash==true):
			Dash_x=-1
		elif(mazafakaDaash==false):
			move_vect.x -= 1
		
#	if mazafakaDaash == true:
#		$PlayerAnim.play("Dash")
#		if move_vect.x == -1:
#			$PlayerAnim.play("DashL")
#		elif move_vect.x == 1:
#			$PlayerAnim.play("DashR")
		
		
	move_vect = move_vect.normalized()
	move_and_collide(move_vect * MOVE_SPEED * delta)
	
	if move_vect != Vector2(0, 0) && mazafakaDaash == false:
		$PlayerAnim.play("walk")
	elif move_vect == Vector2(0, 0) && mazafakaDaash == false:
		$PlayerAnim.play("stay")


func MovingDash(delta):
	var dash_vect = Vector2(0, 0)
	dash_vect.x = Dash_x
	dash_vect.y = Dash_y
	
	if mazafakaDaash == true:
		if Dash_x == -1:
			$PlayerAnim.play("DashL")
		elif Dash_x == 1:
			$PlayerAnim.play("DashR")
		elif Dash_x == 0:
			#ВСтавь анимацию прыжка посерерине.
			$PlayerAnim.play("DashR")
	
	dash_vect = dash_vect.normalized()
	move_and_collide(dash_vect * DASH_SPEED * delta)


func Hands_showing_and_rotate():
	current_hand.global_rotation = player_hands.look_angle_hand
	var h_s = player_hands
	h_s.body_is_right
	h_s.hand_is_up
	if h_s.body_is_right == true:
		if h_s.hand_is_up == true:
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.show()
			$PBodyRight/PHand2.hide()
			current_hand = $PBodyRight/PHand1
		if h_s.hand_is_up == false:
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.hide()
			$PBodyRight/PHand2.show()
			current_hand = $PBodyRight/PHand2
	elif h_s.body_is_right == false:
		if h_s.hand_is_up == true:
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.show()
			$PBodyLeft/PHand2.hide()
			current_hand = $PBodyLeft/PHand1
		if h_s.hand_is_up == false:
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.hide()
			$PBodyLeft/PHand2.show()
			current_hand = $PBodyLeft/PHand2
		pass

func Mouse_looking():
	var look_vec = get_global_mouse_position() - current_hand.global_position
	var look_angle = look_vec.angle() #atan2(look_vec.y, look_vec.x)
	$PBodyRight/PHand1.global_rotation = look_angle
	$PBodyRight/PHand2.global_rotation = look_angle
	$PBodyLeft/PHand1.global_rotation = look_angle
	$PBodyLeft/PHand2.global_rotation = look_angle
	if mazafakaDaash == false:
		Detect_mouse_position(look_angle)

func Eat():
	$Health.frame = GLOBAL.PlayerHP
	$HealthAnim.play("Show Healts")

func Detect_mouse_position(look_angle):
	#используется для рук с правой стороны
	if current_hand == $PBodyRight/PHand2 or current_hand == $PBodyRight/PHand1:
		if look_angle > -2 and look_angle < 0:#Первая четверть
			current_hand = $PBodyRight/PHand2
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.hide()
			$PBodyRight/PHand2.show()
		elif look_angle > 0 and look_angle < 2:#Четвёртая четверть
			current_hand = $PBodyRight/PHand1
			$PBodyRight.show()
			$PBodyLeft.hide()
			$PBodyRight/PHand1.show()
			$PBodyRight/PHand2.hide()
		else:#Если мышка слева
			current_hand = $PBodyLeft/PHand2
	#используется для рук с левой стороны
	if current_hand == $PBodyLeft/PHand2 or current_hand == $PBodyLeft/PHand1:
		if look_angle > -4 and look_angle < -1:#Вторая четверть
			current_hand = $PBodyLeft/PHand2
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.hide()
			$PBodyLeft/PHand2.show()
		elif look_angle > 1 and look_angle < 4:#Третья четверть
			current_hand = $PBodyLeft/PHand1
			$PBodyRight.hide()
			$PBodyLeft.show()
			$PBodyLeft/PHand1.show()
			$PBodyLeft/PHand2.hide()
		else:#Если мышка справа
			current_hand = $PBodyRight/PHand2


func Damage(damage, area):
	GLOBAL.PlayerHP -= damage
	if GLOBAL.PlayerHP > 0:
		$Health.frame = GLOBAL.PlayerHP
		$Damage_particles.emitting = true
		$Damage_particles.global_rotation = area.global_rotation
	else: $Health.frame = 0
	$HealthAnim.play("Show Healts")
	$HealthTimer.start()
	can_damage = false

 
func _DetectArea_area_entered(area):
	if area.is_in_group("Damage") and GLOBAL.PlayerHP > 0 && can_damage == true: 
		if area.is_in_group("Enemy_bullet"):
			Damage(1, area) #GLOBAL.PlayerHP == 3 or 
		if area.is_in_group("Explosion"):
			Damage(2, area)
		if GLOBAL.PlayerHP < 1:
			Dead(area)
	elif area.is_in_group("Gun"):
#		GLOBAL.PlayerHaveGun = true сучка неробит 
		PlayerUpGun()

func Dead(area):
	$Player_dead.global_rotation_degrees = area.global_rotation_degrees + 45
	$PlayerAnim.play("dead")
	GLOBAL.PlayerDead = true
	CAMERA.get_node("TEXT").Show_text("DEAD", "[R]", false)


func HealthTimer_timeout():
	pass


func PlayerAnim_anim_finished(anim_name):
	if anim_name == "ready":
		ready = true
	if anim_name == "Dash" or anim_name == "DashR" or anim_name == "DashL":
		$DashDelayTimer.start()
		mazafakaDaash=false
		Dash_x = 0
		Dash_y = 0




