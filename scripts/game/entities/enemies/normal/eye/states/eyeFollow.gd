extends State
class_name EyeFollow

#variaveis
@export var moveSpeed := 40

@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

func Enter():
	#muda a animacao para a de seguir
	enemy.get_node("sprite").animation = "follow"
	#toca a animacao de seguir
	enemy.get_node("sprite").play()

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o player
	var distance = Enemies.getDistance(player.global_position, enemy.global_position)
	#faz o inimigo seguir o player
	Enemies.follow(distance, enemy, moveSpeed)

	#verifica se a distancia e maior que 60
	if distance.length() > 60:
		#muda o estado para parado
		Transitioned.emit(self, "walk")
