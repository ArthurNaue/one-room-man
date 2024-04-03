extends StaticBody2D
class_name WeaponBuyer

@export var game: Node2D
@export var player: CharacterBody2D
@onready var interactText = $interactText
@onready var priceText = $priceText
@onready var sellAudio = $sellAudio
var sellPrice: int

func _ready():
	if player.currentWeapon != null:
		rerollSellPrice()
	else:
		sellPrice = randi_range(1, 3)
		priceText.text = "+$" + str(sellPrice)

func _process(_delta):
	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			if player.currentWeapon != null:
				player.currentWeapon.queue_free()
				#toca o som de vender a arma
				sellAudio.play()
				game.coins += sellPrice
				rerollSellPrice()

func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		interactText.visible = true
		priceText.visible = true

func _on_hitbox_area_exited(_area):
	interactText.visible = false
	priceText.visible = false

func rerollSellPrice():
	if player.currentWeapon.upgraded == false:
		sellPrice = randi_range(1, 3)
	else:
		sellPrice = randi_range(4, 6)
	priceText.text = "+$" + str(sellPrice)
