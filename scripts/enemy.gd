extends CharacterBody2D

@export var speed = 40
var player = null
var player_chase = false
var displacement= Vector2.ZERO
var health = 100
var player_inattack_zone = false
var can_take_damage = true

@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	update_helth()
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
	if body.has_method("player"):
		player_inattack_zone= true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone= false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack:
		if can_take_damage:
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health: ",health)
			if health<=0:
				health = 0
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_helth():
	var health_bar = $healthbar
	health_bar.value=health
	if health>=100:
		health_bar.visible = false
	else:
		health_bar.visible = true
		
