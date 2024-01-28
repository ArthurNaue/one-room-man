extends State
class_name ShadowCatFollow

#variaveis
@export var moveSpeed := 40
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

func Enter():
	#muda a animacao para a de seguir
	enemy.get_node("sprite").animation = "follow"
	#toca a animacao de seguir
	enemy.get_node("sprite").play()
	#espera 5 segundos
	await get_tree().create_timer(5).timeout
	#troca de estado
	Transitioned.emit(self, "handAttack")

func Physics_Update(delta: float):
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var direction = player.global_position - enemy.global_position

	#faz o inimigo andar na direcao
	enemy.velocity = direction.normalized() * moveSpeed
