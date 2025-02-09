extends CharacterBody2D
###
#Link Variables
@onready var player: AnimatedSprite2D = $Player
@onready var pov: Camera2D = $PointOfView
@onready var aura: CPUParticles2D = $AuraParticles
@onready var cooldown: RichTextLabel = $CooldownText
@onready var slidetimer: Timer = $Player/SlideTimer
@onready var delaytimer: Timer = $Player/DelayTimer
@onready var cooldowntimer: Timer = $Player/CooldownTimer
@onready var invisibilitytimer: Timer = $Player/InvisibilityTimer
@onready var iframetimer: Timer = $Player/InvincibilityFrameTimer
#Attributes
@export var Speed: int = 50
@export var JUMP_VELOCITY: int = -175
@export var Damage: int = 20
@export var Health: int = 100
#Stuff
var Border = Vector2(1280, 2304)
var SlideCooldown = true

### Animations, Functions ###
#Idle
func idle_animation():
	player.play("Idle")
	#Normal Speed
	Speed = 50
#Walking
func walking_animation():
	player.play("Walking")
	#Normal Speed
	Speed = 50
	if Input.is_action_pressed("ui_left"):
		player.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		player.flip_h = false
#Running
func running_animation():
	player.play("Running")
	#Sprinting Speed
	Speed = 75
	if Input.is_action_pressed("ui_left"):
		player.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		player.flip_h = false
#Jumping
func jumping_animation():
	player.play("Jumping")
	if Input.is_action_pressed("ui_left"):
		player.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		player.flip_h = false
#Sliding
func sliding_animation():
	if SlideCooldown == true:
		player.play("Sliding")
		slidetimer.start()
		#Slide Speed
		Speed = 150
		if Input.is_action_pressed("ui_left"):
			player.flip_h = true
		elif Input.is_action_pressed("ui_right"):
			player.flip_h = false
		await get_tree().create_timer(0.8).timeout
		SlideCooldown = false
		#Normal Speed
		Speed = 50
	elif SlideCooldown == false:
		cooldown.visible = true
		print("Player tried to slide, Slide ability on cooldown.")
		await get_tree().create_timer(0.5).timeout
		cooldown.visible = false

#Vanishing
func disappearing_animation():
	player.play("Disappearing")
#Dying
func dying_animation():
	#Nullified Speed
	Speed = 0
	player.play("Dying")
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_scene()
	
#Process
func _process(delta: float) -> void:
	#global_position = clamp(global_position, Vector2.ZERO, Border)
	if Health <= 0:
		dying_animation()
	else:
		pass
	if Input.is_action_pressed("Slide"):
		sliding_animation()
	elif Input.is_action_pressed("ui_accept"):
		jumping_animation()
	elif Input.is_action_pressed("Sprint"):
		running_animation()
	elif Input.is_action_pressed("ui_left"):
		walking_animation()
	elif Input.is_action_pressed("ui_right"):
		walking_animation()
	else:
		idle_animation()
		

#Handle Physics
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	move_and_slide()

#Timers/Cooldowns
func _on_slide_timer_timeout() -> void:
	SlideCooldown = true
