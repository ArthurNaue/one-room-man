extends State
class_name EyeFollow

#variaveis
@onready var enemy = get_parent().get_parent()
@export var moveSpeed := 40
@onready var player = get_tree().get_first_node_in_group("player")

func Enter():
	#muda a animacao para a de seguir
	enemy.get_node("sprite").animation = "follow"
	#toca a animacao de seguir
	enemy.get_node("sprite").play()

func Physics_Update(_delta):
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var direction = player.global_position - enemy.global_position
	
	#faz o inimigo andar na direcao
	enemy.velocity = direction.normalized() * moveSpeed

	#verifica se a distancia e maior que 60
	if direction.length() > 60:
		#muda o estado para parado
		Transitioned.emit(self, "walk")
