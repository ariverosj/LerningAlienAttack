extends Area2D

signal  enemy_die

signal enemy_hit

@export var speed= 300
@export var life=2  


func _physics_process(delta):
	_move(delta)

func _move(delta):
	global_position.x -= speed*delta

func die():
	life -= 1 
	if life <1:
		queue_free()
		emit_signal("enemy_die")
	else: 
		print("se deberia disparar el sonido")
		emit_signal("enemy_hit")

func instaDie():
	queue_free()

func _on_body_entered(body):
	body.take_damage()
	queue_free()
