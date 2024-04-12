extends CharacterBody2D
class_name Player

#variaveis
@onready var sprite = $sprite
@onready var weaponsNode = $weapons
@onready var hands = $weapons/hands
@onready var handsCol = $weapons/hands/handsHitbox/col
@onready var weaponBuyer = get_tree().get_first_node_in_group("weaponBuyer")
@onready var currentWeapon: Node2D
@onready var currentWeaponScene: PackedScene
@onready var currentWeaponImage: Texture
@onready var game = get_tree().get_first_node_in_group("game")

#faz a variavel que decide a arma do pickup
var weaponPickupScene: PackedScene
#faz a variavel de cooldown da arma
var weaponCooldown: float
#faz a variavel que controla o lado da mao
var leftHand = true
#faz a variavel que verifica se a arma ta com o upgrade ativo
var weaponUpgraded: bool

func _process(delta: float):
	weaponCooldown -= delta
	if weaponCooldown < 0:
		weaponCooldown = 0
	
	#verifica se o player clicou Q
	if Input.is_action_just_pressed("Q"):
		#verifica se o player tem alguma arma
		if currentWeapon != null:
			#spawna o objeto de pickup da arma
			game.spawnWeaponPickup(currentWeaponScene, currentWeaponImage, global_position, weaponUpgraded)
			#deleta a arma da mao do player
			currentWeapon.queue_free()
	
	#verifica se o player ta sem arma
	if currentWeapon == null:
		#faz as maos ficarem visiveis
		hands.visible = true
		#verifica se foi clicado o botao esquerdo do mouse
		if Input.is_action_just_pressed("mouse_left"):
			#verifica se o cooldown acabou
			if weaponCooldown <= 0:
				#ativa a colisao
				handsCol.disabled = false
				#verifica qual a mao do ataque
				if leftHand == true:
					#muda a animacao para a de ataque
					hands.animation = "leftHandAttack"
					hands.play()
				else:
					#muda a animacao para a de ataque
					hands.animation = "rightHandAttack"
					hands.play()
	else:
		#faz as maos ficarem invisiveis
		hands.visible = false
		#verifica se a arma do player esta upgradeada
		weaponUpgraded = currentWeapon.upgraded

	#toca a animacao
	sprite.play()

func _physics_process(_delta):
	move_and_slide()

#funcao de spawnar a arma
func spawnWeapon(weaponScene: PackedScene, weaponImage: Texture, upgraded: bool):
	#verifica se o player ja tem uma arma
	if currentWeapon != null:
		#spawna o objeto de pickup da arma
		game.spawnWeaponPickup(currentWeaponScene, currentWeaponImage, global_position, weaponUpgraded)
		#deleta a arma
		currentWeapon.queue_free()
	#spawna a arma
	var weapon = weaponScene.instantiate() as Node2D
	currentWeapon = weapon
	currentWeaponScene = weaponScene
	currentWeaponImage = weaponImage
	weaponsNode.add_child(weapon)
	currentWeapon.upgraded = upgraded
	#ajusta o preco da loja de compra de armas
	weaponBuyer.rerollSellPrice()

func _on_hands_animation_finished():
	#reseta o cooldown
	weaponCooldown = 2
	#desabilita a colisao
	handsCol.disabled = true
	#troca de mao
	if leftHand == true:
		leftHand = false
	else: 
		leftHand = true

#funcao de verificar se houve uma colisao
func _on_hands_hitbox_area_entered(area):
	#verifica se o objeto colidido e um player
	if area.is_in_group("enemy"):
		#verifica se pode sofrer dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 1
			#aplica 1 de dano
			area.Damage(attack)
