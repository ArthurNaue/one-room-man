extends State
class_name wingedCrystalSecondAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var player = get_tree().get_first_node_in_group("player")

const moveSpeed = 75

var phaseInitFinished = false

func Enter():
	#toca a animacao de entrar na segunda fase
	enemy.get_node("phasesAnim").play("secondPhaseInit")
	
func Physics_Update(_delta):
	#verfica se a animacao de entrada da segunda fase acabou
	if phaseInitFinished == true:
		#define a distancia entre o inimigo e o player
		var distance = Enemies.getDistance(player.global_position, enemy.global_position)
		#faz o inimigo seguir o player
		Enemies.follow(distance, enemy, moveSpeed)

func _on_phases_anim_animation_finished(_anim_name):
	#ativa a variavel que sinaliza que a animacao de inicio acabou
	phaseInitFinished = true
	#toca a animacao de ataque da segunda fase
	enemy.get_node("attackAnim").play("secondAttackWalk")
	
