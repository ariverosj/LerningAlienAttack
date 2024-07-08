extends Node2D

@export var playerLife= 3
@export var enemy_Score=100

@export var score= 0

@onready var uiGame= $UI/UIGame
@onready var ui= $UI
var game_over_screen_scene = preload("res://UI/game_over_screen.tscn")

@onready var enemyHitSound = $enemyHit
@onready var explode_Sound = $ExplodeSound

signal player_die

func _ready():
	uiGame.set_new_score(score)
	uiGame.set_life(playerLife)

func _on_player_player_take_damage():
	playerLife -= 1 
	print("Life = " + str(playerLife))
	uiGame.set_life(playerLife)
	if playerLife<1:
		emit_signal("player_die")
		_game_over_ui()
		
func _on_enemy_die():
	explode_Sound.play()
	score += enemy_Score
	uiGame.set_new_score(score)

func _on_enemy_spawner_enemy_spawn(enemy_instance):
	enemy_instance.connect("enemy_die",_on_enemy_die)
	enemy_instance.connect("enemy_hit",_on_enemy_hit)
	add_child(enemy_instance)

func _game_over_ui():
	await get_tree().create_timer(1.5).timeout
	var gos= game_over_screen_scene.instantiate()
	ui.add_child(gos)
	gos.set_score(score)

func _on_enemy_hit():
	print("Sound play")
	enemyHitSound.play()
	


func _on_enemy_spawner_enemy_path_spawn(enemy_path_instance):
	add_child(enemy_path_instance)
	enemy_path_instance.enemy.connect("enemy_die",_on_enemy_die)
	enemy_path_instance.enemy.connect("enemy_hit",_on_enemy_hit)
