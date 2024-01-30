extends StaticBody2D
class_name Shop

@export var game: Node2D
@onready var interactText = $interactText
@onready var priceText = $priceText
var price: int
var weaponNumber: int
var weaponScene : PackedScene
var weaponImg : Texture

func _ready():
	rerollPrice()

func _process(_delta):
	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			if game.coins >= price:
				game.coins -= price
				game.spawnWeaponPickup(weaponScene, weaponImg, Vector2(150, 50))
				rerollPrice()

func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		interactText.visible = true
		priceText.visible = true

func _on_hitbox_area_exited(area):
	interactText.visible = false
	priceText.visible = false

func rerollPrice():
	price = randi_range(5, 10)
	weaponNumber = randi_range(1, 3)
	if weaponNumber == 1:
		weaponScene = Weapons.dagger
		weaponImg = Weapons.daggerImg
	elif weaponNumber == 2:
		weaponScene = Weapons.pistol
		weaponImg = Weapons.pistolImg
	elif weaponNumber == 3:
		weaponScene = Weapons.bomb
		weaponImg = Weapons.bombImg
	priceText.text = "-$" + str(price)
