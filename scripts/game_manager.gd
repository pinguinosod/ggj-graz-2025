extends Node

const TURRET_COST: int = 100

var mainScene: PackedScene = preload("res://scenes/main.tscn")
var mainMenuScene: PackedScene = preload("res://scenes/main_menu.tscn")
var gameStarted = false
var vehicleUpgradeLevel: int = 1
var resources: int = 100
var currentVeinLevel: int = 1
var veinResources: int = 50

signal veinDeepleted
signal movementStarted
signal minningStarted

func doMine() -> void:
	if veinResources > 0:
		veinResources -= 1
		resources += 1
	else:
		veinDeepleted.emit()

func addResources(howMuch: int) -> void:
	resources += howMuch

func spendResources(howMuch: int) -> bool:
	if howMuch <= resources:
		resources -= howMuch
		return true
	return false

func startMinning() -> void:
	currentVeinLevel += 1
	veinResources = currentVeinLevel * 20 # 200
	minningStarted.emit()

func loadMainScene() -> void:
	gameStarted = true
	get_tree().change_scene_to_packed(mainScene)

func loadMainMenu() -> void:
	gameStarted = false
	get_tree().change_scene_to_packed(mainMenuScene)
