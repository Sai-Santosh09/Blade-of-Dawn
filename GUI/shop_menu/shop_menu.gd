extends CanvasLayer

const ERROR = preload("res://GUI/shop_menu/audio/error.wav")
const OPEN_SHOP = preload("res://GUI/shop_menu/audio/open_shop.wav")
const PURCHASE = preload("res://GUI/shop_menu/audio/purchase.wav")
const SHOP_ITEM_BUTTON = preload("res://GUI/shop_menu/shop_item_button.tscn")

signal shown
signal hidden


var is_active : bool = false

@onready var close_button: Button = %CloseButton
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var shop_items_container: VBoxContainer = %ShopItemsContainer


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide_menu()
	close_button.pressed.connect( hide_menu )
	pass


func _unhandled_input( event : InputEvent ) -> void:
	if is_active == false:
		return 
	
	if event.is_action_pressed( "pause" ):
		get_viewport().set_input_as_handled()
		hide_menu()


func show_menu( items : Array[ ItemData ], dialog_triggered : bool = true ) -> void:
	if dialog_triggered:
		await DialogSystem.finished
	enable_menu()
	populate_item_list( items )
	play_audio( OPEN_SHOP )
	shown.emit()
	pass


func hide_menu() -> void:
	enable_menu( false )
	clear_item_list()
	hidden.emit()
	pass


func enable_menu( _enabled : bool = true ) -> void:
	get_tree().paused = _enabled
	visible = _enabled
	is_active = _enabled
	pass


func clear_item_list() -> void:
	for c in shop_items_container.get_children():
		c.queue_free()
	pass


func populate_item_list( items : Array[ ItemData ] ) -> void:
	for item in items:
		var shop_item : ShopItemButton = SHOP_ITEM_BUTTON.instantiate()
		shop_item.setup_item( item )
		shop_items_container.add_child( shop_item )
		pass
	pass


func play_audio( _audio : AudioStream ) -> void:
	audio_stream_player.stream = _audio
	audio_stream_player.play()
	pass
