extends State
class_name bombKingFollow

#variaveis
@export var moveSpeed: int
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")
@export var stateTimer: Timer
var newState: int

func Enter():
	#comeca o timer pra trocar de estado
	stateTimer.start()
	#muda a animacao para a de seguir
	enemy.get_node("sprite").animation = "walk"
	#toca a animacao de seguir
	enemy.get_node("sprite").play()

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o player
	var distance = Enemies.getDistance(player.global_position, enemy.global_position)
	#faz o inimigo seguir o player
	Enemies.follow(distance, enemy, moveSpeed)

func _on_state_timer_timeout():
	#escolhe o proximo estado
	newState = randi_range(1, 4)
	match newState:
		1, 2, 3:
			Transitioned.emit(self, "bombAttack")
		4:
			Transitioned.emit(self, "midBombAttack")
