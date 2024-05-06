extends State
class_name WingedCrystalFourthAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

const moveSpeed = 80

func Enter():
	#toca a animacao de entrar na quarta fase
	enemy.get_node("phasesAnim").play("fourthPhaseInit")
	#toca a animacao de ataque da quarta fase
	enemy.get_node("attackAnim").play("fourthAttackAnim")

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o local desejado
	var distance = Enemies.getDistance(player.global_position, enemy.global_position)
	#faz o inimigo andar ate o local desejado
	Enemies.follow(distance, enemy, moveSpeed)
