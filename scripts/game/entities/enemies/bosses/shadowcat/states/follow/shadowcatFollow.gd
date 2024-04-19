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
	#faz o inimigo seguir o player
	Enemies.follow(player.global_position, enemy, moveSpeed)

func _on_state_timer_timeout():
	#escolhe o proximo estado
	newState = randi_range(1, 2)
	match newState:
		1:
			Transitioned.emit(self, "handAttack")
		2:
			Transitioned.emit(self, "slashAttack")
