extends State
class_name shadowCatFollow

#variaveis
@export var moveSpeed: int
@export var stateTimer: Timer
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")
var newState: int

func Enter():
	#comeca o timer de mudar de estado
	stateTimer.start()
	#muda a animacao para a de seguir
	enemy.get_node("sprite").animation = "follow"
	#toca a animacao de seguir
	enemy.get_node("sprite").play()

func Physics_Update(_delta):
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var direction = player.global_position - enemy.global_position

	#faz o inimigo andar na direcao
	enemy.velocity = direction.normalized() * moveSpeed

func _on_state_timer_timeout():
	#escolhe o proximo estado
	newState = randi_range(1, 2)
	match newState:
		1:
			Transitioned.emit(self, "handAttack")
		2:
			Transitioned.emit(self, "slashAttack")
