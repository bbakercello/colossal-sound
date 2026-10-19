class_name Inventory
extends Resource


var _items: Array[String] = []


func add(item: String) -> void:
	if _items.has(item):
		return
	_items.append(item)


func has_item(item: String) -> bool:
	return _items.has(item)
