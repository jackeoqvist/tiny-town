class_name InventorySlot
extends RefCounted

var item_data: ItemData
var quantity: int

func _init(p_resource: ItemData, p_quantity: int):
	self.item_data = p_resource
	self.quantity = p_quantity
