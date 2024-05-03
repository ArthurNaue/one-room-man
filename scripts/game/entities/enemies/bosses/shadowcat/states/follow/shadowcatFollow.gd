extends State
class_name shadowCatFollow

#variaveis
@export var moveSpeed: int
@export var stateTimer: Timer

@onready var enemy = get_parent().get_parent()
@onready var sprite = enemy.get_node("sprite")
@onready var player = get_tree().get_first_node_in_group("player")

var newState: int

func Enter():
	#muda a animacao para a de seguir
	sprite.animation = "follow"
	#toca a animacao
	sprite.play()
	#comeca o timer de mudar de estado
	stateTimer.start()

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o player
	var distance = Enemies.getDistance(player.global_position, enemy.global_position)
	#faz o inimigo seguir o player
	Enemies.follow(distance, enemy, moveSpeed)

func _on_state_timer_timeout():
	#escolhe o proximo estado
	newState = randi_range(1, 2)
	match newState:
		1:
			Transitioned.emit(self, "handAttack")
		2:
			Transitioned.emit(self, "slashAttack")
