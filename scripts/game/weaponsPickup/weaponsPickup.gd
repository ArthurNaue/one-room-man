extends StaticBody2D
class_name WeaponPickup

@export var weaponScene: PackedScene
@export var image: Texture
@onready var pickupTextNode = $pickupText
@onready var sprite = $sprite
@onready var anim = $anim
@onready var player = get_parent().get_node("player")
@onready var pickupScene = self

func _ready():
	sprite.texture = image
	pickupText(false)
	anim.play("pickup")

func _process(_delta):
	if pickupTextNode.visible == true:
		if Input.is_action_just_pressed("E"):
			pickup()

func _on_area_col_area_exited(area):
	if area.is_in_group("player"):
		pickupText(false)

func pickup():
	#spawna a arma
	player.spawnWeapon(weaponScene, image)
	#deleta o pickup
	queue_free()

func pickupText(desiredVisibility: bool):
	pickupTextNode.visible = desiredVisibility
