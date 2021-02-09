extends Node
class_name EnemyClass, "res://Recources/Enemy.png"

var Type
var positionX
var positionY

func _init(var type,x ,y):
	Type = type
	positionX = x
	positionY = y	

func _ready():
	pass
