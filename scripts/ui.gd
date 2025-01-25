extends CanvasLayer

@onready var resources = $Control/MarginContainer/VBoxContainer/HBoxContainer2/LabelResources
@onready var veinResources = $Control/MarginContainer/VBoxContainer/HBoxContainer/LabelVeinResources
@onready var label_shield_gen_health: Label = $Control/MarginContainer/VBoxContainer/HBoxContainer3/LabelShieldGenHealth


func _process(delta: float) -> void:
	resources.text = str(GameManager.resources)
	veinResources.text = str(GameManager.veinResources)
	label_shield_gen_health.text = str(GameManager.shieldGeneratorHealth)
