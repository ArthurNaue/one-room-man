extends StaticBody2D
class_name WeaponUpgrader

@export var game: Node2D
@export var player: CharacterBody2D
@export var weaponBuyer: StaticBody2D
@onready var interactText = $interactText
@onready var priceText = $priceText
var upgradePrice: int

func _ready():
	rerollUpgradePrice()

func _process(_delta):
	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			if game.coins >= upgradePrice:
				if player.currentWeapon != null:
					if player.currentWeapon.upgraded == false:
						game.coins -= upgradePrice
						player.currentWeapon.upgraded = true
						rerollUpgradePrice()
						weaponBuyer.rerollSellPrice()

func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		interactText.visible = true
		priceText.visible = true

func _on_hitbox_area_exited(_area):
	interactText.visible = false
	priceText.visible = false

func rerollUpgradePrice():
	upgradePrice = randi_range(15, 20)
	priceText.text = "+$" + str(upgradePrice)
