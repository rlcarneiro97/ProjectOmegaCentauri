extends KinematicBody2D

var animacao = "PistolAnimation"

var velocidade = 150
const gravidade = 10
const forcaPulo = -400

var move = Vector2()
const vetorNormal = Vector2(0, -1)

func _process(delta):
	
	if Input.is_action_just_pressed("botaoRapido1"):
		animacao = "PistolAnimation"
		$PistolAnimation.visible = true
		$DualPistolAnimation.visible = false
		$SmgAnimation.visible = false
	elif Input.is_action_just_pressed("botaoRapido2"):
		animacao = "DualPistolAnimation"
		$DualPistolAnimation.visible = true
		$PistolAnimation.visible = false
		$SmgAnimation.visible = false
	elif Input.is_action_just_pressed("botaoRapido3"):
		animacao = "SmgAnimation"
		$SmgAnimation.visible = true
		$DualPistolAnimation.visible = false
		$PistolAnimation.visible = false
	
	_move()
	
func _move():
	
	move.y += gravidade
	move.x = 0
	
	if Input.is_action_pressed("direita"):
		move.x = velocidade

		if Input.is_action_pressed("atirar"):
			get_node(animacao).flip_h = false
			get_node(animacao).play("RunShootingForward")
		else:
			get_node(animacao).flip_h = false
			get_node(animacao).play("Run")
		
	elif Input.is_action_pressed("esquerda"):
		move.x = -velocidade
		
		if Input.is_action_pressed("atirar"):
			get_node(animacao).flip_h = true
			get_node(animacao).play("RunShootingForward")
		else:
			get_node(animacao).flip_h = true
			get_node(animacao).play("Run")
		
	elif Input.is_action_just_pressed("atirar") and get_node(animacao).flip_h == false:
		get_node(animacao).play("IdleShootingForward")
		get_node(animacao).flip_h = false

	elif Input.is_action_just_pressed("atirar") and get_node(animacao).flip_h == true:
		get_node(animacao).play("IdleShootingForward")
		get_node(animacao).flip_h == true
		
	elif Input.is_action_pressed("atirar") and get_node(animacao).flip_h == false:
		get_node(animacao).play("IdleShootingForward")
		get_node(animacao).flip_h = false

	elif Input.is_action_pressed("atirar") and get_node(animacao).flip_h == true:
		get_node(animacao).play("IdleShootingForward")
		get_node(animacao).flip_h == true
		
	elif Input.is_action_just_pressed("recarregar") and get_node(animacao).flip_h == false:
			get_node(animacao).flip_h = false
			get_node(animacao).play("IdleReload")
	
	elif Input.is_action_just_pressed("recarregar") and get_node(animacao).flip_h == true:
			get_node(animacao).flip_h = true
			get_node(animacao).play("IdleReload")

	if Input.is_action_just_pressed("pular") and is_on_floor():
		move.y = forcaPulo
		
	move = move_and_slide(move, vetorNormal)


func _on_PistolAnimation_animation_finished():
	get_node(animacao).play("Idle")

func _on_DualPistolAnimation_animation_finished():
	get_node(animacao).play("Idle")

func _on_RifleAnimation_animation_finished():
	get_node(animacao).play("Idle")
