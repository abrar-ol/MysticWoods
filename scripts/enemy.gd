extends CharacterBody2D

@export var speed = 40
var player = null
var player_chase = false
var displacement= Vector2.ZERO
var health = 100
var player_inattack_zone = false

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	deal_with_damage()
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
		

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	print(body)
	if body.has_method("player"):
		print("slime attacks player")
		player_inattack_zone= true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		print("slime not in attack zone")
		player_inattack_zone= false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack:
		health -= 20
		print("slime health: ",health)
		if health<0:
			self.queue_free()
