extends Path2D

@export var progressSpeed= 0.2
@onready var pathFallow=$PathFollow2D
@onready var enemy= $PathFollow2D/enemy

func _ready():
	pathFallow.set_progress_ratio(1)

func _process(delta):
	pathFallow.progress_ratio -= progressSpeed*delta
	if pathFallow.progress_ratio<=0:
		queue_free()
	
