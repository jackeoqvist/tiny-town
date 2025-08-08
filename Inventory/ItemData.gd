class_name ItemData
extends Resource

@export var name : String = "Item Name"
@export var texture: Texture2D
@export var is_stackable: bool = false
@export_range(1, 999) var max_stack_size: int = 99
