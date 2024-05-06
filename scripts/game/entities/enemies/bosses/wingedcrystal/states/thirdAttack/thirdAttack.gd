extends State
class_name WingedCrystalThirdAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var enemyHealth = enemy.get_node("health")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var thirdAttackTimer = $thirdAttackTimer

func Enter():
	#faz o inimigo ficar parado
	enemy.velocity = Vector2.ZERO
	#para a animacao do inimigo
	enemy.get_node("attackAnim").stop()
	#toca a animacao de entrar na terceira fase
	enemy.get_node("phasesAnim").play("thirdPhaseInit")
	#espera a animacao acabar
	await get_tree().create_timer(1).timeout
	#comeca o timer de atirar
	thirdAttackTimer.start()

func Update(_delta):
	#verifica se a vida do inimigo esta em 1/4
	if enemyHealth.health <= (enemyHealth.maxHealth * 0.25):
		Transitioned.emit(self, "fourthAttack")

func Exit():
	#para o timer do ataque
	thirdAttackTimer.stop()

func _on_third_attack_timer_timeout():
	#ataca
	attack()

func attack():
	#toca a animacao do terceiro ataque
	enemy.get_node("attackAnim").play("thirdAttackAnim")
	#espera a animacao acabar
	await get_tree().create_timer(0.2).timeout
	#atira
	Enemies.shoot(enemy.global_position, player.global_position, "crystalBullet", 160)
