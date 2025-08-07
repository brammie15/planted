extends Node2D
class_name PlantPot

@onready var plant_sprite = $Plant
@onready var pot_sprite = $Pot

var has_plant = false
var grow_stage = 0
var is_shoveled = false

const MAX_GROWTH = 5

func _ready():
	plant_sprite.visible = grow_stage > 0

func load_from_save(new_position: Vector2, new_grow_stage: int, shoveled: bool):
	self.global_position = new_position
	is_shoveled = shoveled
	grow_stage = new_grow_stage
	pot_sprite.frame = shoveled
	
	if grow_stage > 0:
		has_plant = true
		plant_sprite.frame = grow_stage
		plant_sprite.visible = true

func grow():
	if has_plant and grow_stage < MAX_GROWTH:
		grow_stage += 1
		plant_sprite.frame = grow_stage

func use_seed():
	if is_shoveled and not has_plant:
		has_plant = true
		grow_stage = 0
		plant_sprite.frame = grow_stage
		plant_sprite.visible = true

func use_shears():
	if has_plant and grow_stage == MAX_GROWTH:
		GameState.Score += 1
		has_plant = false
		is_shoveled = false
		plant_sprite.visible = false
		pot_sprite.frame = 0
		grow_stage = 0

func use_shovel():
	if not has_plant:
		is_shoveled = true
		pot_sprite.frame = 1

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		match GameState.CurrentTool:
			GameState.TOOL.SHOVEL:
				use_shovel()
			GameState.TOOL.SHEARS:
				use_shears()
			GameState.TOOL.SEED:
				use_seed()
			GameState.TOOL.REMOVE:
				queue_free()

func _on_timer_timeout():
	grow()
	$Timer.wait_time = randf_range(4.0, 7.0)
