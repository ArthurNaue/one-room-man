extends State
class_name WingedCrystalMidState

#variaveis
@export var moveSpeed: int

@onready var enemy = get_parent().get_parent()

func Physics_Update(_delta):
	#define a distancia entre o inimigo e o meio
	var distance = Enemies.getDistance(Enemies.mid, enemy.global_position)
	#verifica a distancio entre o player e o meio
	if distance.length() < 1:
		#faz o inimigo parar
		enemy.velocity = Vector2.ZERO
		#muda para o estado de ataque
		Transitioned.emit(self, "attack")
	else:
		#faz o inimigo ir para o meio 
		Enemies.follow(distance, enemy, moveSpeed)
