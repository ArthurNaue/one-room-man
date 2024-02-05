extends StaticBody2D
class_name Coin	

#variaveis
@onready var game = get_parent()

func _on_hitbox_area_entered(area):
	#verifica se a area entrada e um player
	if area.is_in_group("player"):
		#toca o som de pickup
		playPickupSound()
		#adiciona uma moeda no jogo
		game.addCoin()
		#se auto-destroi
		queue_free()

#funcao de tocar o som de pickup
func playPickupSound():
	#faz o node do jogo tocar o som de pickup
	game.get_node("coinPickupSound").play()
