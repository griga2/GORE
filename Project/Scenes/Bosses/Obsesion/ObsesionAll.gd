extends Node2D

var BossHP = 100

func _ready():
	pass

func BossCheck():
	print("XYETA ", BossHP)

func BossDamage(HowDamage):
	if BossHP >= HowDamage && BossHP >= 0:
		BossHP -= HowDamage
