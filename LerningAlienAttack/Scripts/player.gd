extends CharacterBody2D

var veloctyScalar=300

@export var shoot_Time=0.7

var rocket_scene= preload("res://Units/rocket.tscn")

@onready var rocketContainer = $RocketContainer #get_node 
@onready var shoot_timer_Relay=$ShootTimerRelay
@onready var shoot_audio= $Shoot_audio

signal player_take_damage

func _process(delta):
	_shoot()

func _physics_process(delta):
	moveplayer()

func moveplayer():
	_playerStop()
	_moveTo()
	move_and_slide()
	_clambingPosition()

func _playerStop():
	velocity=Vector2(0,0)

func _moveTo():
	if Input.is_action_pressed("move_right"):
		velocity.x=veloctyScalar
	if Input.is_action_pressed("move_left"):
		velocity.x=-veloctyScalar
	if Input.is_action_pressed("move_up"):
		velocity.y=-veloctyScalar
	if Input.is_action_pressed("move_down"):
		velocity.y=veloctyScalar

func _clambingPosition():
	var screen_size =get_viewport_rect().size
	global_position.x= clampf(global_position.x,0,screen_size.x)
	global_position.y= clampf(global_position.y,50,screen_size.y-50)

func _shoot():

	if Input.is_action_just_pressed("shoot") && shoot_timer_Relay.is_stopped():
		instantiate_rocket()
		shoot_timer_Relay.start(shoot_Time)
		shoot_audio.play()

func instantiate_rocket():
	var rocket_instance = rocket_scene.instantiate()
	rocketContainer.add_child(rocket_instance)
	rocket_instance.global_position= global_position
	rocket_instance.global_position.x +=60

func take_damage():
	emit_signal("player_take_damage")
	

func _on_main_scene_player_die():
	print("player Die")
	queue_free()
