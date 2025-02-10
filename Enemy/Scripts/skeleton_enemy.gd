extends CharacterBody2D
#@onready var player: AnimatedSprite2D = $Player
#@onready var pov: Camera2D = $PointOfView
#@onready var aura: CPUParticles2D = $AuraParticles
#@onready var cooldown: RichTextLabel = $CooldownText
#@onready var damagetick: RichTextLabel = $DamageTickText
#@onready var slidetimer: Timer = $SlideTimer
#@onready var delaytimer: Timer = $DelayTimer
#@onready var cooldowntimer: Timer = $CooldownTimer
#@onready var invisibilitytimer: Timer = $InvisibilityTimer
#@onready var iframetimer: Timer = $InvincibilityFrameTimer

var SPEED = 30.0
var JUMP_VELOCITY = -200.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
