extends CharacterBody2D

signal Inventory_updated(newInv)

@export var speed : float = 300

var Inventory: Array[InventorySlot] = []
@export var Inventory_size: int = 12

func _ready() -> void:
	Inventory.resize(Inventory_size)
	Inventory.fill(null)
	print("Inventory initialized with empty slots: ", Inventory)

func _physics_process(delta: float) -> void:
	
	if Input.is_key_pressed(KEY_E):
		$InventoryUI.visible = not $InventoryUI.visible
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * speed * delta
	
	move_and_slide()


func addItem(newItem: ItemData):
	# First, try to stack the item if possible
	if newItem.is_stackable:
		for i in range(Inventory.size()):
			var slot = Inventory[i]
			# Check if slot has the same item and stack is not full
			if slot and slot.resource == newItem and slot.quantity < newItem.max_stack_size:
				slot.quantity += 1
				Inventory_updated.emit(Inventory)
				return true # Item stacked successfully

	# Find the next empty slot
	for i in range(Inventory.size()):
		if Inventory[i] == null:
			# Create a new InventorySlot object instead of a Dictionary
			Inventory[i] = InventorySlot.new(newItem, 1)
			Inventory_updated.emit(Inventory)
			print("Picked up: ", newItem.item_name)
			return true

	print("Inventory is full!")
	return false
