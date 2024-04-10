extends StaticBody2D
class_name RoundButton

var oncooldown: bool
@onready var interactText = $interactText
@onready var sprite = $sprite
@onready var game = get_parent()

func _ready():
	#toca a animacao
	sprite.play()

func _process(_delta):
	#verifica se tem alguma entidade viva
	if game.entitiesAlive <= 0:
		#ativa o botao
		oncooldown = false
		#troca a animacao do botao 
		sprite.animation = "unpressed"
	else:
		#desativa o botao
		oncooldown = true
		#troca a animacao do botao 
		sprite.animation = "pressed"

	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			buttonPressed()

func _on_hitbox_area_entered(area):
	if oncooldown == false:
		if area.is_in_group("player"):
			interactText.visible = true

func _on_hitbox_area_exited(area):
	if area.is_in_group("player"):
		interactText.visible = false

func buttonPressed():
	if oncooldown == false:
		interactText.visible = false
		oncooldown = true
		sprite.play()
		get_parent().nextRound()

func _on_sprite_animation_changed():
	sprite.play()
