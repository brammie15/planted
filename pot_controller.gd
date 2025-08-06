extends Node2D

@export var pot_scene: PackedScene

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if GameState.CurrentTool == GameState.TOOL.POT:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var pot = pot_scene.instantiate()
			pot.position = get_global_mouse_position()
			get_tree().current_scene.add_child(pot)
