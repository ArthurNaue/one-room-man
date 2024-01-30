extends Node2D
class_name Game

@export var level: int
@export var weaponPickupScene: PackedScene
@export var coinScene: PackedScene
var coins = 0

func _ready():
	spawnEntitie(Enemies.eye, Vector2(140, 150))
	spawnEntitie(Enemies.eye, Vector2(140, 150))
	spawnEntitie(Enemies.eye, Vector2(140, 150))
	spawnEntitie(Enemies.shadowcat, Vector2(140, 150))
	spawnWeaponPickup(Weapons.dagger, Weapons.daggerImg, Vector2(50, 250))
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 250))
	spawnWeaponPickup(Weapons.bomb, Weapons.bombImg, Vector2(250, 250))
	spawnCoin(Vector2(260, 250))

func _process(_delta):
	#verifica se o player clicou ESQ
	if Input.is_action_just_pressed("esq"):
		#fecha o jogo
		get_tree().quit()

func spawnEntitie(entitieScene: PackedScene, entitiePosition: Vector2):
	var entitie = entitieScene.instantiate() as CharacterBody2D
	entitie.global_position = entitiePosition
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
