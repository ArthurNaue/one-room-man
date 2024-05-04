extends Node2D
class_name EnemiesNode

#variaveis
const mid = Vector2(152, 152)

@onready var eye = load("res://scenes/game/entities/enemies/normal/eye/root/eye.tscn")
@onready var slime = load("res://scenes/game/entities/enemies/normal/slime/slime.tscn")
@onready var mage = load("res://scenes/game/entities/enemies/normal/mage/root/mage.tscn")
@onready var crystal = load("res://scenes/game/entities/enemies/normal/crystal/root/crystal.tscn")

@onready var shadowcat = load("res://scenes/game/entities/enemies/bosses/shadowcat/root/shadowcat.tscn")
@onready var bombking = load("res://scenes/game/entities/enemies/bosses/bombking/root/bombKing.tscn")
@onready var wingedcrystal = load("res://scenes/game/entities/enemies/bosses/wingedcrystal/wingedcrystal.tscn")

@onready var bulletScene = load("res://scenes/game/entities/enemies/bullet/enemyBullet.tscn")
@onready var bombScene = load("res://scenes/game/entities/enemies/bosses/bombking/bombAttack/bomb/bombKingBomb.tscn")
@onready var crystalScene = load("res://scenes/game/entities/enemies/normal/crystal/bullet/crystalBullet.tscn")

@onready var game = get_tree().get_first_node_in_group("game")
@onready var player = get_tree().get_first_node_in_group("player")

#funcao de pegar a distancia 
func getDistance(target: Vector2, enemy: Vector2):
	#define a distancia
	var distance = target - enemy
	#retorna a distancia
	return distance

#funcao de seguir
func follow(distance, enemy: Node2D, moveSpeed: int):
	#faz o inimigo andar na direcao
	enemy.velocity = distance.normalized() * moveSpeed

#funcao de atirar
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
