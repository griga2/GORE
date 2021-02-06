extends Node

var body_is_right = true
var hand_is_up = true
var look_angle_hand
var look_angle_body

func _lol(text):
	print(text)

func Check_angle(object, hand, body):
	var look_vec_from_hand = object - hand
	look_angle_hand = look_vec_from_hand.angle()
	var look_vec_from_body = object - body
	look_angle_body = look_vec_from_body.angle()
	CheakUseingHand(look_angle_hand, look_angle_body)


func CheakUseingHand(look_angle_hand, look_angle_body):
	if look_angle_body > -1.5 && look_angle_body <= 1.7 || look_angle_body > -1.5 && look_angle_body <= 0.8:
		body_is_right = true
		if look_angle_hand > -2 and look_angle_hand <= 0:
			hand_is_up = false
		elif look_angle_hand > 0 and look_angle_hand < 2:
			hand_is_up = true
		#else: body_is_right = false
	else:
		body_is_right = false
		if look_angle_hand > -4 and look_angle_hand <= -1:
			hand_is_up = false
		elif look_angle_hand > 1 and look_angle_hand < 4:
			hand_is_up = true




