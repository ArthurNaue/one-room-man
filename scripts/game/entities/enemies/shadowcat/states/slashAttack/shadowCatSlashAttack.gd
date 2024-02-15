extends State
class_name ShadowCatSlashAttack

#variaveis
@export var direction: ShadowCatDirection
@export var slashAttackScene: PackedScene
@export var enemyBulletScene: PackedScene
@onready var enemy = get_parent().get_parent()
@onready var game = get_tree().get_first_node_in_group("game")

func Enter():
	#muda a animacao para a de parado
	enemy.get_node("sprite").animation = "idle"
	#faz o inimigo ficar parado
	enemy.velocity = Vector2.ZERO
	await get_tree().create_timer(0.4).timeout
	#muda a direcao para apontar pro player
	direction.Direction()
	#ataca
	attack()
	#espera 0.2 segundos
	await get_tree().create_timer(0.4).timeout
	Transitioned.emit(self, "follow")

#funcao de ataque
func attack():
	#define o objeto de ataque
	var slashAttack = slashAttackScene.instantiate() as Area2D
	#define o objeto da bala
	var enemyBullet = enemyBulletScene.instantiate() as CharacterBody2D
	#spawna o objeto de ataque
	enemy.get_node("direction").add_child(slashAttack)
	#muda a posicao da balaaaaaa
	enemyBullet.global_position = enemy.global_position
	#spawna o objeto da bala
	game.add_child(enemyBullet)
