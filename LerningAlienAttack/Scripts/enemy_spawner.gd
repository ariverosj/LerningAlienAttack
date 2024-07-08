extends Node2D

signal enemy_spawn(enemy_instance)

signal enemy_path_spawn(enemy_path_instance)

var enemy_scene= preload("res://Units/enemy.tscn")
var enemy_path = preload("res://Units/Spawn/enemy_path.tscn")
var random = RandomNumberGenerator.new()
@onready var timerPaht = $Timerpath 
@onready var spawnPosition= $SpawnPosition

func _ready():
	timerPaht.set_wait_time(random.randf_range(1, 4))

func _on_timer_timeout():
	_enemySpawn()  # Replace with function body.
	

func _enemySpawn(): 
	var spawnPositionList = spawnPosition.get_children()
	var spawnPositionRandom= spawnPositionList.pick_random()
	_instantiate_enemy(spawnPositionRandom.global_position)

func _instantiate_enemy(spawnPosition):
	var enemy_instance= enemy_scene.instantiate()
	enemy_instance.global_position=spawnPosition
	#add_child(enemy_instance)
	emit_signal("enemy_spawn",enemy_instance)


func _on_timerpath_timeout():
	var enemy_path_instance = enemy_path.instantiate()
	emit_signal("enemy_path_spawn",enemy_path_instance)
	timerPaht.set_wait_time(random.randf_range(1, 4))
	print(timerPaht.get_time_left())
