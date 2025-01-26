extends Node

const TURRET_COST: int = 100

var mainScene: PackedScene = preload("res://scenes/main.tscn")
var endScene: PackedScene = preload("res://scenes/end_screen.tscn")
var mainMenuScene: PackedScene = preload("res://scenes/main_menu.tscn")
var introScene: PackedScene = preload("res://scenes/intro_scene.tscn")
var gameStarted = false
var vehicleUpgradeLevel: int = 2
var resources: int = 900
var currentVeinLevel: int = 1
var veinResources: int = 50
var shieldGeneratorHealth: int = 100

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
	veinResources = currentVeinLevel * 50 # 200
	minningStarted.emit()

func damageShieldGenerator(dmg: int) -> void:
	shieldGeneratorHealth -= dmg
	if shieldGeneratorHealth <= 0:
		restartVariables()
		loadEndScene()

func loadEndScene() -> void:
	get_tree().change_scene_to_packed(endScene)

func loadIntroScene() -> void:
	get_tree().change_scene_to_packed(introScene)

func loadMainScene() -> void:
	restartVariables()
	gameStarted = true
	get_tree().change_scene_to_packed(mainScene)

func loadMainMenu() -> void:
	gameStarted = false
	get_tree().change_scene_to_packed(mainMenuScene)

func restartVariables() -> void:
	vehicleUpgradeLevel = 2
	resources = 150
	currentVeinLevel = 1
	veinResources = 50
	shieldGeneratorHealth = 100
