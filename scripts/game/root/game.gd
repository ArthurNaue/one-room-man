extends Node2D
class_name Game

@export var level: int
@export var weaponPickupScene: PackedScene
@export var coinScene: PackedScene
@onready var hudRounds = $hudRounds
@onready var roundText = $roundText
@onready var newRoundTimer = $newRoundTimer
var enemyPosition: Vector2
var rounds = 1
var coins = 0

func _ready():
	spawnWeaponPickup(Weapons.pistol, Weapons.pistolImg, Vector2(150, 150))

func _process(_delta):
	#atualiza o frame do hud de rounds
	hudRounds.frame = (rounds - 1)
	#verifica se o player clicou ESQ
	if Input.is_action_just_pressed("esq"):
		#fecha o jogo
		get_tree().quit()
	roundText.text = str(int(newRoundTimer.time_left))

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

func _on_new_round_timer_timeout():
	rounds += 1
	for x in rounds:
		randomizeEnemyPosition()
		spawnEntitie(Enemies.eye, enemyPosition)
	match rounds:
		5:
			spawnEntitie(Enemies.shadowcat, Vector2(150, 100))
		10:
			spawnEntitie(Enemies.shadowcat, Vector2(150, 100))

func randomizeEnemyPosition():
	enemyPosition = Vector2(randf_range(70, 230), randf_range(70, 150))
