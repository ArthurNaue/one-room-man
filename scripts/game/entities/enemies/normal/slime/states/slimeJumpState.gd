extends State
class_name SlimeJumpState

@export var speed: int
@export var enemy: CharacterBody2D
@export var animation: AnimatedSprite2D

@onready var player = get_tree().get_first_node_in_group("player")

var playerPosition: Vector2
var distance

func Enter():
	#define a posicao do player
	playerPosition = player.global_position
	#define a distancia entre o inimigo e o player
	distance = Enemies.getDistance(playerPosition, enemy.global_position)
	#faz o inimigo andar na direcao
	Enemies.follow(distance, enemy, speed)
	#muda a animacao para a de pulo
	animation.animation = "jumping"
	#toca a animacao
	animation.play()

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o player
	distance = Enemies.getDistance(playerPosition, enemy.global_position)
	#verifica a distancia
	if distance.length() < 2:
		Transitioned.emit(self, "idle")
