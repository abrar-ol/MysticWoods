extends CharacterBody2D

@export var speed := 6000
@onready var animated_sprite = $AnimatedSprite2D
enum {LEFT,RIGHT,UP,DOWN}
var faces = {LEFT:false,RIGHT:false, UP:false, DOWN:false}

func _physics_process(delta):
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
