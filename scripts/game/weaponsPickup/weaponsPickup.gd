extends StaticBody2D
class_name WeaponPickup

@export var weaponScene: PackedScene
@export var image: Texture
@onready var pickupTextNode = $pickupText
@onready var sprite = $sprite
@onready var anim = $anim
@onready var player = get_tree().get_first_node_in_group("player")
@onready var pickupScene = self
var upgraded: bool

func _ready():
	sprite.texture = image
	pickupText(false)
	anim.play("pickup")

func _process(_delta):
	if pickupTextNode.visible == true:
		if Input.is_action_just_pressed("E"):
			pickup()

#veririfica se o pickup colidiu
func _on_area_col_area_entered(area):
	#verifica se a colisao e um player
	if area.is_in_group("player"):
		#ativa a visibilidade do texto de pickup
		pickupText(true)

#verifica se a colisao acabou
func _on_area_col_area_exited(area):
	#verifica se a colisao e um player
	if area.is_in_group("player"):
		#desativa a visibilidade do texto de pickup
		pickupText(false)

func pickup():
	#spawna a arma
	player.spawnWeapon(weaponScene, image, upgraded)
	#deleta o pickup
	queue_free()

func pickupText(desiredVisibility: bool):
	pickupTextNode.visible = desiredVisibility

