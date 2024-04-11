extends CharacterBody2D
class_name Mage

#variaveis
@export var speed: int
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	#cria a variavel de distancia
	var distance = player.global_position - global_position
	#verifica a distancia entre o inimigo e o destino
	if distance.length() < 100:
		#inverte a velocidade aplicada no inimigo
		velocity = Vector2.ZERO
	else:
		#faz o inimigo ir ate o player
		velocity = distance * 0.2

	move_and_slide()

func _on_shoot_timer_timeout():
	#atira a bala
	Enemies.shoot(global_position, player.global_position, "bullet", 200)
