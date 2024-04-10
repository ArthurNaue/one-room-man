extends CharacterBody2D
class_name Player

@export var speed: float
@export var weaponCooldown: float
@export var weaponPickupScene: PackedScene
@onready var sprite = $sprite
@onready var weaponsNode = $weapons
@onready var hands = $weapons/hands
@onready var handsCol = $weapons/hands/handsHitbox/col
@onready var currentWeapon: Node2D
@onready var currentWeaponScene: PackedScene
@onready var currentWeaponImage: Texture
#faz um Vector2 zerado
var inputVector = Vector2.ZERO
#faz a variavel que controla o lado da mao
var leftHand = true
#faz a variavel que verifica se a arma ta com o upgrade ativo
var weaponUpgraded: bool

func _process(delta: float):
	weaponCooldown -= delta
	if weaponCooldown < 0:
		weaponCooldown = 0
	
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
	#adiciona a direcao do player ao Vector2
	inputVector.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	inputVector.y = Input.get_action_strength("S") - Input.get_action_strength("W")
	#estabiliza os numeros do Vector2
	inputVector = inputVector.normalized()
	
	#verifica se tem alguma direcao para ir
	if inputVector:
		#altera a velocidade do player baseado na direcao 
		velocity = inputVector * speed
		#muda a animacao para a de andar
		sprite.animation = "walk"
	else:
		#faz o player parar de andar
		velocity = Vector2.ZERO
		#muda a animacao para a de parado
		sprite.animation = "idle"

	#muda a direcao da sprite com base na direcao do player
	if Input.is_action_just_pressed("D"):
		sprite.flip_h = false
	elif Input.is_action_just_pressed("A"):
		sprite.flip_h = true
	
	move_and_slide()

#funcao de spawnar a arma
func spawnWeapon(weaponScene: PackedScene, weaponImage: Texture, upgraded: bool):
	#verifica se o player ja tem uma arma
	if currentWeapon != null:
		spawnWeaponPickup()
		#deleta a arma
		currentWeapon.queue_free()
	#spawna a arma
	var weapon = weaponScene.instantiate() as Node2D
	currentWeapon = weapon
	currentWeaponScene = weaponScene
	currentWeaponImage = weaponImage
	weaponsNode.add_child(weapon)
	currentWeapon.upgraded = upgraded

#funcao de spawnar o objeto de pickup da arma
func spawnWeaponPickup():
	#faz o objeto de pickup 
	var weaponPickup = weaponPickupScene.instantiate() as StaticBody2D
	#define os parametros do objeto de pickup
	weaponPickup.weaponScene = currentWeaponScene
	weaponPickup.image = currentWeaponImage
	weaponPickup.global_position = global_position
	weaponPickup.upgraded = weaponUpgraded
	#spawna o objeto de pickup
	get_parent().add_child(weaponPickup)

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
