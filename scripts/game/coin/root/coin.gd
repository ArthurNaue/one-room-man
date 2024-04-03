extends StaticBody2D
class_name Coin	

#variaveis
@export var coinSprite1: Texture
@export var coinSprite2: Texture
@export var coinSprite3: Texture
@export var coinSprite4: Texture
@onready var game = get_parent()
@onready var sprite = $sprite
var coinType: int
var amount: int

func _ready():
	match coinType:
		1:
			#muda a textura da moeda
			sprite.texture = coinSprite1
			#muda a quantidade de moedas que o jogador recebe
			amount = coinType
		2:
			#muda a textura da moeda
			sprite.texture = coinSprite2
			#muda a quantidade de moedas que o jogador recebe
			amount = coinType
		10:
			#muda a textura da moeda
			sprite.texture = coinSprite4
			#muda a quantidade de moedas que o jogador recebe
			amount = 5

func _on_hitbox_area_entered(area):
	#verifica se a area entrada e um player
	if area.is_in_group("player"):
		#toca o som de pickup
		playPickupSound()
		#adiciona a quantidade de moedas para as moedas do jogador
		game.addCoin(amount)
		#se auto-destroi
		queue_free()

#funcao de tocar o som de pickup
func playPickupSound():
	#faz o node do jogo tocar o som de pickup
	game.get_node("coinPickupSound").play()
