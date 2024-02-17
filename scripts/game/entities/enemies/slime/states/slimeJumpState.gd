extends State
class_name SlimeJumpState

@export var speed: int
@export var enemy: CharacterBody2D
@export var animation: AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("player")
var playerPosition: Vector2
var enemyPosition: Vector2

func Enter():
	#seta a posicao do player
	playerPosition = player.global_position
	#toca a animacao
	animation.play()
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var moveDirection = playerPosition - enemy.global_position
	#faz o inimigo andar na direcao
	enemy.velocity = moveDirection.normalized() * speed

func Physics_Update(_delta):
	enemyPosition = enemy.global_position
	var direction = enemy.global_position - playerPosition
	if direction.length() < 2:
		Transitioned.emit(self, "idle")
