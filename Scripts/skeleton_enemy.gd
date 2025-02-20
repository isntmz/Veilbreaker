extends CharacterBody2D
###
#Link Variables
@onready var skeleton: AnimatedSprite2D = $SkeletonEnemy
@onready var directiontimer: Timer = $SkeletonEnemy/DirectionTimer
@onready var delaybetweenhits: Timer = $SkeletonEnemy/AttackDelayTimer
@onready var iframetimer: Timer = $SkeletonEnemy/InvincibilityFrameTimer
#Attributes
@export var Health = 100
@export var Damage = 10
@export var Speed = 30

func walking():
	skeleton.play("Walking")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
