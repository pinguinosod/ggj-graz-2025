extends Node2D

func _hide_all() -> void:
	$CanvasLayer/StartSlide.visible = false
	$CanvasLayer/Slide1.visible = false
	$CanvasLayer/Slide2.visible = false
	
func _on_button_pressed() -> void:
	_hide_all()
	$CanvasLayer/Slide1.visible = true


func _on_slide_1_pressed() -> void:
	_hide_all()
	$CanvasLayer/Slide2.visible = true


func _on_button_Slide2_pressed() -> void:
	_hide_all()
	GameManager.loadMainScene()
