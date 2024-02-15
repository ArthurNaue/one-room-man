extends Node2D
class_name Game

#variaveis
@export var weaponPickupScene: PackedScene
@export var coinScene: PackedScene
@export var rounds = 1
@onready var hudRounds = $hudRounds
var coins = 0

func _ready():
	#spawna o primeiro inimigo
	spawnEntitie(Enemies.shadowcat)
	#spawna a primeira arma
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150))

func _process(_delta):
	#atualiza o frame do hud de rounds
	hudRounds.frame = (rounds - 1)
	#verifica se o player clicou ESQ
	if Input.is_action_just_pressed("esq"):
		#fecha o jogo
		get_tree().quit()

#funcao que spawna uma entidade
func spawnEntitie(entitieScene: PackedScene):
	#faz o objeto da entidade
	var entitie = entitieScene.instantiate() as CharacterBody2D
	#define a posicao do objeto da entidade
	entitie.global_position = randomizeEnemyPosition()
	#spawna o objeto da entidade
	add_child(entitie)

#funcao de spawnar uma arma no chao
func spawnWeaponPickup(choosenWeaponPickupScene: PackedScene, image: Texture, desiredPosition: Vector2):
	#faz o objeto da arma
	var weaponPickup = weaponPickupScene.instantiate() as StaticBody2D
	#define os parametros do objeto da arma
	weaponPickup.weaponScene = choosenWeaponPickupScene
	weaponPickup.image = image
	weaponPickup.global_position = desiredPosition
	#spawna o objeto da arma
	add_child(weaponPickup)

#funcao de spawnar uma moeda
func spawnCoin(desiredPosition: Vector2):
	#faz o obejto da moeda
	var coin = coinScene.instantiate() as StaticBody2D
	#define a posicao do objeto da moeda
	coin.global_position = desiredPosition
	#spawna o objeto da moeda
	add_child(coin)

#funcao de adicionar uma moeda
func addCoin():
	#adiciona um as moedas
	coins += 1

#funcao de randomizar a posicao de spawn do inimigo
func randomizeEnemyPosition():
	#retorna uma posicao aleatoria de spawn
	return Vector2(randf_range(70, 230), randf_range(70, 150))

#funcao ativada quando passa para o proximo round
func nextRound():
	#passa para o proximo round
	rounds += 1
	#verifica qual o round atual
	match rounds:
		2, 3, 4:
			#spawna os inimigos de acordo com o round
			for x in rounds:
				spawnEntitie(Enemies.eye)
		5:
			#spawna os inimigos de acordo com o round
			spawnEntitie(Enemies.shadowcat)
		6, 7, 8, 9:
			#spawna os inimigos de acordo com o round
			for x in (rounds - 3):
				spawnEntitie(Enemies.eye)
		10:
			#spawna os inimigos de acordo com o round
			spawnEntitie(Enemies.shadowcat)
			spawnEntitie(Enemies.shadowcat)
