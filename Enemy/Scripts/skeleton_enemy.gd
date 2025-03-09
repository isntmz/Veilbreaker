extends CharacterBody2D
###
#Link Variables
@onready var skeleton: AnimatedSprite2D = $SkeletonEnemy
#Attributes
var victim = playervar.new()
@export var target = victim

func _ready():
	pass

func idle():
	skeleton.play("Idle")

func _process(delta):
	if target.global_position:
		idle()
