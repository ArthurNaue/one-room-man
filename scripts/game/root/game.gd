extends Node2D
class_name Game

@export var level: int
@export var weaponPickupScene: PackedScene
@export var coinScene: PackedScene
var coins = 100

func _ready():
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150))

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
