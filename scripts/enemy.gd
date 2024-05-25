extends CharacterBody2D

@export var speed = 40
var player = null
var player_chase = false
var displacement= Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if player_chase:
		displacement = player.position-position
		position += displacement/speed
		if displacement.y <0:
			animated_sprite.play("back_walk")
		else:
			if displacement.x >-10 && displacement.x <10:
				animated_sprite.play("front_walk")
			else:
				animated_sprite.play("side_walk")
				
			if displacement.x <0:
				animated_sprite.flip_h=true
			else:
				animated_sprite.flip_h=false

func _on_detection_area_body_entered(body):
	player = body
	player_chase =true


func _on_detection_area_body_exited(body):
	player_chase = false
	if displacement.y <0:
		animated_sprite.play("back_idle")
	else :
		if displacement.x >-10 && displacement.x <10:
			animated_sprite.play("front_idle")
		else:
			animated_sprite.play("side_idle")
		
