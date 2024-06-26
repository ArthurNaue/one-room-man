extends Node2D
class_name Game

#variaveis
@onready var weaponPickupScene = load("res://scenes/game/pickups/weaponsPickup/root/weaponPickup.tscn")
@onready var coinScene = load("res://scenes/game/coin/coin.tscn")
@onready var hudRounds = $hudRounds

var coins: int
var rounds: int
var entitiesAlive: int

func _ready():
	#spawna a primeira arma
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150), false)

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
	#adiciona 1 no numero de entidades vivas
	entitiesAlive += 1

#funcao de spawnar uma arma no chao
func spawnWeaponPickup(choosenWeaponPickupScene: PackedScene, image: Texture, desiredPosition: Vector2, upgraded: bool):
	#faz o objeto da arma
	var weaponPickup = weaponPickupScene.instantiate() as StaticBody2D
	#define os parametros do objeto da arma
	weaponPickup.weaponScene = choosenWeaponPickupScene
	weaponPickup.image = image
	weaponPickup.global_position = desiredPosition
	weaponPickup.upgraded = upgraded
	#spawna o objeto da arma
	add_child(weaponPickup)

#funcao de spawnar uma pocao no chao
func spawnPotionPickup(desiredPosition: Vector2, type: PackedScene):
	#cria o objeto de pocao
	var potionPickup = type.instantiate() as StaticBody2D
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
			spawnEntitie(Enemies.bombinion)
		4:
			for i in 1:
				spawnEntitie(Enemies.eye)
			for i in 2:
				spawnEntitie(Enemies.bombinion)
		5:
			spawnEntitie(Enemies.bombking)
		6:
			spawnEntitie(Enemies.mage)
		7:
			spawnEntitie(Enemies.slime)
			spawnEntitie(Enemies.mage)
		8:
			for i in 2:
				spawnEntitie(Enemies.mage)
			spawnEntitie(Enemies.slime)
		9:
			for i in 3:
				spawnEntitie(Enemies.mage)
			spawnEntitie(Enemies.slime)
		10:
			spawnEntitie(Enemies.shadowcat)
		11:
			for i in 3:
				spawnEntitie(Enemies.mage)
			spawnEntitie(Enemies.slime)
		12:
			for i in 2:
				spawnEntitie(Enemies.crystal)
		13:
			for i in 2:
				spawnEntitie(Enemies.crystal)
			spawnEntitie(Enemies.mage)
		14:
			for i in 4:
				spawnEntitie(Enemies.crystal)
			spawnEntitie(Enemies.mage)
		15:
			spawnEntitie(Enemies.wingedcrystal)
		16:
			get_tree().change_scene_to_file("res://scenes/demoEndScreen/demoEndScreen.tscn")
