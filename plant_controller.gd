extends Node2D
class_name PlantPot

@onready var plant_sprite = $"Plant"

var _hasPlant = false
var growStage = 0;
var _isShoveld = false

var _maxGrowt = 5

var _isSwaying = false

func loadFromSave(position, growStage):
	self.global_position = position
	if growStage > 0:
		_hasPlant = true
		

func _ready() -> void:
	print("test")
	plant_sprite.visible = growStage > 0
	
func grow():
	print("grow event")
	if(_hasPlant):
		if growStage < _maxGrowt:
			growStage += 1
			plant_sprite.frame = growStage
		if growStage == _maxGrowt and not _isSwaying:
			_isSwaying = true
			var shader = plant_sprite.material as ShaderMaterial
			shader.set_shader_parameter("shouldSway", true)
			shader.set_shader_parameter("time_offset", randf_range(0, TAU))
	
func useSeed():
	if _isShoveld and not _hasPlant:
		print("seed planted")
		_hasPlant = true
		plant_sprite.frame = 0
		growStage = 0
		plant_sprite.visible = true
	
func useShears():
	print("Growstage: " + str(growStage) + " MaxGrowt: " + str(_maxGrowt))
	if _hasPlant and growStage == _maxGrowt:
		print("Plant removed")
		GameState.Score += 1
		plant_sprite.visible = false
		_isShoveld = false
		_hasPlant = false

func useShovel():
	if not _hasPlant:
		print("Plant Shoveled")
		_isShoveld = true

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		match GameState.CurrentTool:
			GameState.TOOL.SHOVEL:
				useShovel()
			GameState.TOOL.SHEARS:
				useShears()
			GameState.TOOL.SEED:
				useSeed()	
			GameState.TOOL.REMOVE:
				queue_free()


func _on_timer_timeout():
	grow()
	$Timer.wait_time = randf_range(4, 7)
