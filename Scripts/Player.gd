extends CharacterBody2D

@export var speed : float = 300

func _ready() -> void:
	print("Hello")

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * speed * delta
	
	move_and_slide()
