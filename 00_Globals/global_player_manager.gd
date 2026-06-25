extends Node


const PLAYER = preload("res://Player/player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://GUI/pause_menu/inventory/player_inventory.tres")

signal camera_shook( trauma : float)
signal interact_pressed
signal player_leveled_up

var interact_handled : bool = true
var player : Player
var player_spawned : bool = false

var level_requirments = [ 0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 2500, 5000, 7500, 10000, 15000, 20000 ]

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true



func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child( player )
	pass

func set_health( hp : int, max_hp : int ) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp( 0 )


func reward_xp( _xp : int ) -> void:
	player.xp += _xp
	#check for level UPs
	if player.xp >= level_requirments[ player.level ]:
		player.level += 1
		player.attack += 1
		player.defense += 1
		player_leveled_up.emit()


func set_player_position( _new_pos : Vector2 ) -> void:
	player.global_position = _new_pos
	pass

func set_as_parent( _p : Node2D ) -> void:
	if player.get_parent():
		player.get_parent().remove_child( player )
	_p.add_child( player )


func unparent_player( _p : Node2D ) -> void:
	_p.remove_child( player )


func play_audio( _audio : AudioStream ) -> void:
	player.audio.stream = _audio
	player.audio.play()


func interact() -> void:
	interact_handled = false
	interact_pressed.emit()


func shake_camera( trauma : float = 1 ) -> void:
	camera_shook.emit( clampf( trauma, 0, 3 ) )
