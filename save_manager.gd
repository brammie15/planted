extends Node

@export var PotScene: PackedScene

func _ready():
	GameState.SaveManager = self

func save_game():
	var save_data = []
	
	for pot in get_tree().get_nodes_in_group("Pots"):
		print(get_tree().get_nodes_in_group("Pots"))
		var pot_data = {
			"position": pot.global_position,
			"growth_stage": pot.growStage
		}
		save_data.append(pot_data)
	
	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	
	print("Game saved!")
	
# steek deze in slides
func string_to_vector2(s: String) -> Vector2:
	print("original: " + s)
	s = s.substr(1, s.length() - 2)	
	print("first: " + s)
	var parts = s.split(",")
	return Vector2(parts[0].to_float(), parts[1].to_float())
	
func load_game():
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
		pot.loadFromSave(string_to_vector2(pot_data["position"]), int(pot_data["growth_stage"]))
		add_child(pot)
		pot.add_to_group("Pots")
	
	print("Game loaded!")
