extends StaticBody2D
class_name Shop

#variaveis
@onready var interactText = $interactText
@onready var priceText = $priceText
@onready var game = get_tree().get_first_node_in_group("game")
@onready var buyAudio = $buyAudio

var price: int
var weaponNumber: int
var weaponScene : PackedScene
var weaponImg : Texture
var pickupPos = Vector2(150, 50)

func _ready():
	rerollPrice()

func _process(_delta):
	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			if game.coins >= price:
				game.coins -= price
				buyAudio.play()
				match weaponNumber:
					1,2,3,4:
						game.spawnWeaponPickup(weaponScene, weaponImg, pickupPos, false)
					5:
						game.spawnPotionPickup(pickupPos, "health")
					6:
						game.spawnPotionPickup(pickupPos, "maxHealth")
				rerollPrice()

func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		interactText.visible = true
		priceText.visible = true

func _on_hitbox_area_exited(_area):
	interactText.visible = false
	priceText.visible = false

func rerollPrice():
	price = randi_range(5, 10)
	weaponNumber = randi_range(6, 6)
	match weaponNumber:
		1:
			weaponScene = Weapons.dagger
			weaponImg = Weapons.daggerImg
		2:
			weaponScene = Weapons.pistol
			weaponImg = Weapons.pistolImg
		3:
			weaponScene = Weapons.bomb
			weaponImg = Weapons.bombImg
		4:
			weaponScene = Weapons.bow
			weaponImg = Weapons.bowImg
	priceText.text = "-$" + str(price)
