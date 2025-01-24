extends Node

var mainScene: PackedScene = preload("res://scenes/main.tscn")
var mainMenuScene: PackedScene = preload("res://scenes/main_menu.tscn")
var gameStarted = false

func loadMainScene() -> void:
	gameStarted = true
	get_tree().change_scene_to_packed(mainScene)


func loadMainMenu() -> void:
	gameStarted = false
	get_tree().change_scene_to_packed(mainMenuScene)
