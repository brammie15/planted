extends CanvasLayer

func _on_shears_button_button_down() -> void:
	GameState.CurrentTool = GameState.TOOL.SHEARS

func _on_shovel_button_button_down() -> void:
	GameState.CurrentTool = GameState.TOOL.SHOVEL

func _on_seed_button_button_down() -> void:
	GameState.CurrentTool = GameState.TOOL.SEED
	
func _on_pot_button_button_down() -> void:
	GameState.CurrentTool = GameState.TOOL.POT

func _on_remove_button_button_down() -> void:
	GameState.CurrentTool = GameState.TOOL.REMOVE
	
func _process(_delta):
	$MarginContainer2/HBoxContainer/ScoreLabel.text = str(GameState.Score)

func _on_save_button_button_down() -> void:
	GameState.SaveManager.save_game();

func _on_load_button_button_down() -> void:
	GameState.SaveManager.load_game();
