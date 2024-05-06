extends State
class_name wingedCrystalSecondAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var enemyHealth = enemy.get_node("health")

const moveSpeed = 150

var phaseInitFinished = false
var corner: int
var direction: Vector2

func Enter():
	#toca a animacao de entrar na segunda fase
	enemy.get_node("phasesAnim").play("secondPhaseInit")
	#espera a animacao acabar
	await get_tree().create_timer(5).timeout
	#ativa a variavel que sinaliza que a animacao de inicio acabou
	phaseInitFinished = true
	#toca a animacao de ataque da segunda fase
	enemy.get_node("attackAnim").play("secondAttackWalk")
	#escolhe uma direcao para ir
	chooseCorner()
	

func Update(_delta):
	#verifica se a vida do inimigo esta na metade
	if enemyHealth.health <= (enemyHealth.maxHealth * 0.5):
		Transitioned.emit(self, "thirdAttack")

func Physics_Update(_delta):
	#verfica se a animacao de entrada da segunda fase acabou
	if phaseInitFinished == true:
		#define a distancia entre o inimigo e o local desejado
		var distance = Enemies.getDistance(direction, enemy.global_position)
		#verifica se o inimigo chegou no local desejado
		if distance.length() > 2:
			#faz o inimigo andar ate o local desejado
			Enemies.follow(distance, enemy, moveSpeed)
		else:
			#escolhe uma direcao para ir
			chooseCorner()

func chooseCorner():
	#escolhe um lado para ir
		corner = randi_range(1,4)
		match corner:
			1:
				direction = Vector2(70, 70)
			2:
				direction = Vector2(230, 70)
			3:
				direction = Vector2(70, 230)
			4:
				direction = Vector2(230, 230)
