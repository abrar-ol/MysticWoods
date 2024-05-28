extends Node

var player_current_attack = false

var current_scene = "main" #world cliff_side
var transition_scene = false

var player_exit_cliffside_posx = 0
var player_exit_cliffside_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene:
		transition_scene = false
		if current_scene == "main":
			current_scene = "cliff_side"
		else:
			current_scene = "main"
