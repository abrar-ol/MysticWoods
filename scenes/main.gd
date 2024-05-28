extends Node2D

func _process(delta):
	change_scene()

func _on_cliffside_transition_area_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_cliffside_transition_area_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene and Global.current_scene == "main":
		Global.finish_changescenes()
		get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
