extends Node2D
class_name Game

#variaveis
@export var weaponPickupScene: PackedScene
@export var potionPickupScene: PackedScene
@export var coinScene: PackedScene
@export var rounds: int
@onready var hudRounds = $hudRounds
var coins = 0

func _ready():
	#spawna a primeira arma
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150))

func _process(_delta):
	#atualiza o frame do hud de rounds
	hudRounds.frame = rounds
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

#funcao de spawnar uma pocao no chao
func spawnPotionPickup(desiredPosition: Vector2):
	#faz o objeto da pocao
	var potionPickup = potionPickupScene.instantiate() as StaticBody2D
	#define a posicao do objeto da pocao
	potionPickup.global_position = desiredPosition
	#spawna o objeto da pocao
	add_child(potionPickup)

#funcao de spawnar uma moeda
func spawnCoin(desiredPosition: Vector2, coinType: int):
	#faz o obejto da moeda
	var coin = coinScene.instantiate() as StaticBody2D
	#define o tipo da moeda
	coin.coinType = coinType
	#define a posicao do objeto da moeda
	coin.global_position = desiredPosition
	#spawna o objeto da moeda
	add_child(coin)

#funcao de adicionar uma moeda
func addCoin(amount: int):
	#adiciona um as moedas
	coins += amount

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
		1:
			spawnEntitie(Enemies.eye)
		2:
			for i in rounds:
				spawnEntitie(Enemies.eye)
		3:
			for i in 2:
				spawnEntitie(Enemies.eye)
			spawnEntitie(Enemies.slime)
		4:
			for i in 1:
				spawnEntitie(Enemies.eye)
			for i in 2:
				spawnEntitie(Enemies.slime)
		5:
			spawnEntitie(Enemies.shadowcat)
		6:
			for i in 3:
				spawnEntitie(Enemies.eye)
			for i in 1:
				spawnEntitie(Enemies.slime)
		7:
			spawnEntitie(Enemies.mage)
			for i in 3:
				spawnEntitie(Enemies.slime)
		8:
			spawnEntitie(Enemies.mage)
			for i in 3:
				spawnEntitie(Enemies.eye)
			for i in 2:
				spawnEntitie(Enemies.slime)
		9:
			spawnEntitie(Enemies.slime)
			for i in 2:
				spawnEntitie(Enemies.mage)
		10:
			spawnEntitie(Enemies.bombking)
