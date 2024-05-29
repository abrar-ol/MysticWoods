extends Node2D

func _ready():
	if Global.is_first_game_loadin:
		$Player.position.x=Global.player_start_posx
		$Player.position.y=Global.player_start_posy
	else:
		$Player.position.x=Global.player_exit_cliffside_posx
		$Player.position.y=Global.player_exit_cliffside_posy


func _process(delta):
	change_scene()
	if is_instance_valid($Player/camera):
		$Player/camera.reset_smoothing()

func _on_cliffside_transition_area_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_cliffside_transition_area_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene and Global.current_scene == "main":
		Global.finish_changescenes()
		Global.is_first_game_loadin = false
		get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
