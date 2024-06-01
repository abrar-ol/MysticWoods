extends StaticBody2D

var can_speak_to_cow = false

func _process(delta):
	#check if player already start the dialogue: stop walking and stop start new dialogue
	if can_speak_to_cow and Input.is_action_just_pressed("dialuge"):
		Dialogic.start("cow_timeline")
		
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		can_speak_to_cow = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		can_speak_to_cow = false
