extends Node

@export var PotScene: PackedScene

func _ready():
	GameState.SaveManager = self

func save_game():
	save_score()
	var save_data = []
	
	for pot in get_tree().get_nodes_in_group("Pots"):
		var pot_data = {
			"position": pot.global_position,
			"grow_stage": pot.grow_stage,
			"is_shoveled": pot.is_shoveled
		}
		save_data.append(pot_data)
	
	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	
	print("Game saved!")
	
	
func save_score():
	var file = FileAccess.open("user://score.txt", FileAccess.WRITE)
	file.store_string(str(GameState.Score))
	file.close()
	print("Saved score")
	
# steek deze in slides
func string_to_vector2(s: String) -> Vector2:
	s = s.substr(1, s.length() - 2)	
	var parts = s.split(",")
	return Vector2(parts[0].to_float(), parts[1].to_float())
	
func load_game():
	load_score()
	var path = "user://save_game.json"
	if not FileAccess.file_exists(path):
		print("No save file found.")
		return

	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var save_data = JSON.parse_string(content)
	if typeof(save_data) != TYPE_ARRAY:
		print("Save file is invalid.")
		return

	for pot in get_tree().get_nodes_in_group("Pots"):
		pot.queue_free()

	for pot_data in save_data:
		var pot = PotScene.instantiate()
		
		var spawnPosition = string_to_vector2(pot_data["position"]) 
		var spawn_growt = int(pot_data["grow_stage"])
		var is_shoveled = bool(pot_data["is_shoveled"])
		
		pot.call_deferred("load_from_save", spawnPosition, spawn_growt, is_shoveled)
		
		get_tree().current_scene.add_child(pot)
		pot.add_to_group("Pots")
	
	print("Game loaded!")

func load_score():
	var path = "user://score.txt"
	if not FileAccess.file_exists(path):
		print("Score file not found")
	
	var file = FileAccess.open(path, FileAccess.READ)
	var score_string = file.get_as_text()
	file.close()
	
	GameState.Score = int(score_string)
	print("score loaded")
