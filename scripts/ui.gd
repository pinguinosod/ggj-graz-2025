extends CanvasLayer

@onready var resources = $Control/MarginContainer/VBoxContainer/HBoxContainer2/LabelResources
@onready var veinResources = $Control/MarginContainer/VBoxContainer/HBoxContainer/LabelVeinResources


func _process(delta: float) -> void:
	resources.text = str(GameManager.resources)
	veinResources.text = str(GameManager.veinResources)
