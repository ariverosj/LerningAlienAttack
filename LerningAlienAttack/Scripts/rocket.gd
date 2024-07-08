extends Area2D
@export var speed=260
@onready var Visible_Screen_Notifier= $VisibleScreenNotifier

func _ready():
	Visible_Screen_Notifier.connect("screen_exited",_on_screen_exited)

func _physics_process(delta):
	moveRocket(delta)

func moveRocket(delta):
	global_position.x +=speed*delta

func _on_screen_exited():
	queue_free()
	
func _on_area_entered(area):
	queue_free()
	area.die()
