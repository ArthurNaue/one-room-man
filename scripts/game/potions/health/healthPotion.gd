extends StaticBody2D
class_name HealthPotion

#variaveis
@onready var playerHealth = get_tree().get_first_node_in_group("player").get_node("health")
@onready var pickupTextNode = $pickupText
@onready var anim = $anim

func _ready():
	anim.play("pickup")

func _process(_delta):
	if pickupTextNode.visible == true:
		if Input.is_action_just_pressed("E"):
			pickup()

func pickup():
	if playerHealth.health < 3:
		#aumenta 1 de vida pro player
		playerHealth.Heal(1)
		#deleta o pickup
		queue_free()

func pickupText(desiredVisibility: bool):
	pickupTextNode.visible = desiredVisibility

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
