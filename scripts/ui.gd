extends CanvasLayer

@onready var resources = $Control/MarginContainer/HBoxContainer/LabelResources



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	resources.text = str(GameManager.resources)
