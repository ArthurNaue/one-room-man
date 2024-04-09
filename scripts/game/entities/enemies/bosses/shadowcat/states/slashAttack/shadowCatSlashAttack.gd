extends State
class_name ShadowCatSlashAttack

#variaveis
@export var direction: enemyDirection
@export var slashAttackScene: PackedScene
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
	await get_tree().create_timer(0.2).timeout
	#muda o estado para o de seguir
	Transitioned.emit(self, "follow")

#funcao de ataque
func attack():
	#define o objeto de ataque
	var slashAttack = slashAttackScene.instantiate() as Area2D
	#spawna o objeto de ataque
	enemy.get_node("direction").add_child(slashAttack)
	#atira uma bala no inimigo
	Enemies.shoot(enemy.global_position, Enemies.player.global_position, "bullet", 200)
