extends Node2D
@onready var coinsprite = $AnimatedSprite2D

signal coincollect

func _process(_delta) -> void:
	coinsprite.play("default")

func _on_area_2d_body_entered(body):
	if body is playervar:
		print("Coin Collected!")
		coincollect.emit()
		queue_free()
