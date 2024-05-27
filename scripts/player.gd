extends CharacterBody2D

@export var speed := 6000
@export var health = 100
@onready var animated_sprite = $AnimatedSprite2D
@onready var enemy_attack_cooldown = $enemy_attack_cooldown
enum {LEFT,RIGHT,UP,DOWN}
var faces = {LEFT:false,RIGHT:false, UP:false, DOWN:false}
var is_enemy_attack = false
var is_enemy_attack_timeout = true

func _physics_process(delta):
	if health<=0 :
		health = 0
		print("Player died :(")
		self.queue_free()
		
	######################### 1
	#if Input.is_action_pressed("move_right"):
		#velocity = Vector2(speed,0)
		#animated_sprite.play("side_walk")
		#animated_sprite.flip_h = false		
		#move_and_slide()		
	#elif Input.is_action_pressed("move_left"):
		#velocity = Vector2(-speed,0)
		#animated_sprite.play("side_walk")
		#animated_sprite.flip_h = true		
		#move_and_slide()		
	#elif Input.is_action_pressed("move_up"):
		#velocity = Vector2(0,-speed)
		#animated_sprite.play("back_walk")
		#animated_sprite.flip_h = false	
		#move_and_slide()		
	#elif Input.is_action_pressed("move_down"):
		#velocity = Vector2(0,speed)
		#animated_sprite.play("front_walk")
		#animated_sprite.flip_h = false		
		#move_and_slide()
		
	######################### 2
	#var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	#velocity += direction * speed * delta
	#animated_sprite.flip_h = false
	#
	#if Input.is_action_pressed("move_right"):
		#animated_sprite.play("side_walk")
	#elif Input.is_action_pressed("move_left"):
		#animated_sprite.play("side_walk")
		#animated_sprite.flip_h = true
	#elif Input.is_action_pressed("move_down"):
		#animated_sprite.play("front_walk")
	#elif  Input.is_action_pressed("move_up"):
		#animated_sprite.play("back_walk")
	#else:
		#animated_sprite.play("front_idle")
	#
	#
	#move_and_slide()
	
	######################### 3
	get_input(delta)
	move_and_slide()
	enemy_attack()
	attack()

func attack():
	pass
	
func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed * delta
	animated_sprite.flip_h = false		
	
	if  input_direction.x < 0:
		animated_sprite.play("side_walk")
		change_face(LEFT)
		animated_sprite.flip_h = true		
	elif input_direction.x > 0:
		animated_sprite.play("side_walk")
		change_face(RIGHT)
	elif  input_direction.y < 0:
		animated_sprite.play("back_walk")
		change_face(UP)
	elif  input_direction.y > 0 :
		animated_sprite.play("front_walk")
		change_face(DOWN)
	
	if input_direction.x == 0 and input_direction.y ==0:
		if faces[LEFT]:
			animated_sprite.play("side_idle")
			animated_sprite.flip_h = true		
			
		elif  faces[RIGHT]:
			animated_sprite.play("side_idle")
		elif faces[UP]:
			animated_sprite.play("back_idle")
		else:
			animated_sprite.play("front_idle")
		
func change_face(face):
	#reset values
	for value in faces:
		faces[value] = false
	
	faces[face] = true

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		print("enemy entered")
		is_enemy_attack = true
		enemy_attack_cooldown.start()		


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		print("enemy exited")		
		is_enemy_attack = false 	
		enemy_attack_cooldown.stop()
		
func enemy_attack():
	if is_enemy_attack_timeout and is_enemy_attack :
		health = health - 20
		print("OUCH!!   "+str(health))
		is_enemy_attack_timeout = false


func _on_enemy_attack_cooldown_timeout():
	is_enemy_attack_timeout = true

func player():
	pass
