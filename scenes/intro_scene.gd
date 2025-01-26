extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Music.play(125)
	$AudioStreamPlayer3D2.play(1)
	$AudioStreamPlayer3D.play(5)
	$AudioStreamPlayer3D3.play(3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func end() -> void:
	GameManager.loadMainScene()

func stopBubbleSounds() -> void:
	$AudioStreamPlayer3D.stop()
	$AudioStreamPlayer3D2.stop()
	$AudioStreamPlayer3D3.stop()
