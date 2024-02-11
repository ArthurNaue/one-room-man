extends Node2D
class_name Game

@export var weaponPickupScene: PackedScene
@export var coinScene: PackedScene
@export var rounds = 1
@onready var hudRounds = $hudRounds
var enemyPosition: Vector2
var coins = 0

func _ready():
	spawnEntitie(Enemies.eye)
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150))

func _process(_delta):
	#atualiza o frame do hud de rounds
	hudRounds.frame = (rounds - 1)
	#verifica se o player clicou ESQ
	if Input.is_action_just_pressed("esq"):
		#fecha o jogo
		get_tree().quit()

func spawnEntitie(entitieScene: PackedScene):
	randomizeEnemyPosition()
	var entitie = entitieScene.instantiate() as CharacterBody2D
	entitie.global_position = enemyPosition
	add_child(entitie)

func spawnWeaponPickup(choosenWeaponPickupScene: PackedScene, image: Texture, desiredPosition: Vector2):
	var weaponPickup = weaponPickupScene.instantiate() as StaticBody2D
	weaponPickup.weaponScene = choosenWeaponPickupScene
	weaponPickup.image = image
	weaponPickup.global_position = desiredPosition
	add_child(weaponPickup)

func spawnCoin(desiredPosition: Vector2):
	var coin = coinScene.instantiate() as StaticBody2D
	coin.global_position = desiredPosition
	add_child(coin)

func addCoin():
	coins += 1

func randomizeEnemyPosition():
	enemyPosition = Vector2(randf_range(70, 230), randf_range(70, 150))

func nextRound():
	rounds += 1
	match rounds:
		2, 3, 4:
			for x in rounds:
				spawnEntitie(Enemies.eye)
		5:
			spawnEntitie(Enemies.shadowcat)
		6, 7, 8, 9:
			for x in (rounds - 3):
				spawnEntitie(Enemies.eye)
		10:
			spawnEntitie(Enemies.shadowcat)
			spawnEntitie(Enemies.shadowcat)
