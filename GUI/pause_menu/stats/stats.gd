class_name Stats extends PanelContainer


@onready var label_level: Label = $VBoxContainer/HBoxContainer/Label2
@onready var label_xp: Label = $VBoxContainer/HBoxContainer2/Label2
@onready var label_attack: Label = $VBoxContainer/HBoxContainer3/Label2
@onready var label_defense: Label = $VBoxContainer/HBoxContainer4/Label2


func _ready() -> void:
	PauseMenu.shown.connect( update_stats )


func update_stats() -> void:
	var _p : Player = PlayerManager.player
	label_level.text = str( _p.level )
	label_xp.text = str( _p.xp )
	label_attack.text = str( _p.attack )
	label_defense.text = str( _p.defense )
	
	pass
