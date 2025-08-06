extends Panel

@export var item: ShopItem

func _ready():
	if item:
		$"ColorRect/MarginContainer/HBoxContainer3/HBoxContainer/ItemName".text = item.name
		$"ColorRect/MarginContainer/HBoxContainer3/HBoxContainer/HBoxContainer/ItemPrice".text = str(item.price)
