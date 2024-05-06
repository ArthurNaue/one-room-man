extends State
class_name wingedCrystalAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var enemyHealth = enemy.get_node("health")
@onready var attackAnim = enemy.get_node("attackAnim")
@onready var readyForShoot = true

var pos: Vector2
var bulletPosition: Vector2
var bulletDirection: Vector2

func Enter():
	#atualiza a posicao do inimigo
	pos = enemy.global_position

func Update(_delta):
	if readyForShoot == true:
		#desativa o ataque
		readyForShoot = false
		#ataca
		attack()
	#verifica se a vida do inimigo esta em 85%
	if enemyHealth.health <= (enemyHealth.maxHealth * 0.85):
		Transitioned.emit(self, "secondAttack")

func attack():
	#seleciona o braco
	var arm = randi_range(1, 4)
	match arm:
		1:
			bulletPosition = Vector2(pos.x - 8, pos.y - 4)
			bulletDirection = Vector2((bulletPosition.x - 1), (bulletPosition.y - 1))
			attackAnim.play("topLeft")
		2:
			bulletPosition = Vector2(pos.x + 8, pos.y - 4)
			bulletDirection = Vector2((bulletPosition.x + 1), (bulletPosition.y - 1))
			attackAnim.play("topRight")
		3:
			bulletPosition = Vector2(pos.x - 8, pos.y + 4)
			bulletDirection = Vector2((bulletPosition.x - 1), (bulletPosition.y + 1))
			attackAnim.play("bottomLeft")
		4:
			bulletPosition = Vector2(pos.x + 8, pos.y + 4)
			bulletDirection = Vector2((bulletPosition.x + 1), (bulletPosition.y + 1))
			attackAnim.play("bottomRight")
	
	#atira
	Enemies.shoot(bulletPosition, bulletDirection, "crystalBullet", 80)
	await get_tree().create_timer(0.6).timeout
	readyForShoot = true
