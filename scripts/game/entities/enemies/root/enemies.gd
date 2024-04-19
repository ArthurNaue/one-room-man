extends Node2D
class_name EnemiesNode

@export var eye: PackedScene
@export var slime: PackedScene
@export var mage: PackedScene
@export var crystal: PackedScene

@export var shadowcat: PackedScene
@export var bombking: PackedScene

@export var bombScene: PackedScene
@export var bulletScene: PackedScene
@export var crystalScene: PackedScene

@onready var game = get_tree().get_first_node_in_group("game")
@onready var player = get_tree().get_first_node_in_group("player")

func follow(target: Vector2, enemy: Node2D, moveSpeed: int):
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var direction = target - enemy.global_position

	#faz o inimigo andar na direcao
	enemy.velocity = direction.normalized() * moveSpeed

func shoot(spawnLocation: Vector2, desiredLocation: Vector2, type: String, speed: int):
	#cria a variavel da cena do tiro
	var shootScene
	#define o tipo do tiro
	if type == "bullet":
		shootScene = bulletScene
	elif type == "bomb":
		shootScene = bombScene
	elif type == "crystalBullet":
		shootScene = crystalScene
	#cria o objeto do tiro
	var shootObj = shootScene.instantiate() as CharacterBody2D
	#define a posicao de spawn do objeto do tiro
	shootObj.global_position = spawnLocation
	#define a direcao que o tiro tem que ir
	shootObj.desiredLocation = desiredLocation
	#define a velocidade do tiro
	shootObj.speed = speed
	#spawna o objeto do tiro
	game.add_child(shootObj)
