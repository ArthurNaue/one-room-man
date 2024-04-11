extends StaticBody2D
class_name RoundButton

#variaveis
@onready var interactText = $interactText
@onready var sprite = $sprite
@onready var game = get_parent()

var oncooldown: bool

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

	#verifica se o texto de interagir esta com a visibilidade ativa
	if interactText.visible == true:
		#verifica se o player clicou E
		if Input.is_action_just_pressed("E"):
			#executa a funcao de apertar o botao
			buttonPressed()

#verifica se alguma area entrou na hitbox
func _on_hitbox_area_entered(area):
	#verfica se a colisao ocorreu com um player
	if area.is_in_group("player"):
		#faz o texto de interagir ficar com a visibilidade ativa
		interactText.visible = true

#verifica se alguma area saiu da hitbox
func _on_hitbox_area_exited(area):
	#verifica se area e um player
	if area.is_in_group("player"):
		#desabilita a visibilidade do texto de interagir
		interactText.visible = false

#funcao de apertar o botao
func buttonPressed():
	#verifica se o cooldown acabou
	if oncooldown == false:
		#ativa o cooldown do botao
		oncooldown = true
		#toca a animacao do botao
		sprite.play()
		#vai pro proximo round
		game.nextRound()

#funcao que executa quando a animacao mudar
func _on_sprite_animation_changed():
	#toca a animacao
	sprite.play()
