extends Control

@export var items: Array[ShopItem]


@onready var shop_root = $"MarginContainer/Panel/MarginContainer/VBoxContainer"

var shop_item_control = preload("res://shopItem.tscn")

func _ready():
	for item in items:
		var shop_item = shop_item_control.instantiate()
		shop_item.item = item
		shop_root.add_child(shop_item)
