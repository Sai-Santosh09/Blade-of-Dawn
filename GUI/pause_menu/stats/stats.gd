class_name Stats extends PanelContainer


@onready var label_level: Label = %Label_lvl
@onready var label_xp: Label = %Label_xp
@onready var label_attack: Label = %Label_attack
@onready var label_defense: Label = %Label_defense
@onready var label_attack_change: Label = %Label_attack_change
@onready var label_defense_change: Label = %Label_defense_change


func _ready() -> void:
	PauseMenu.shown.connect( update_stats )


func update_stats() -> void:
	var _p : Player = PlayerManager.player
	label_level.text = str( _p.level )
	if _p.level < PlayerManager.level_requirments.size():
		label_xp.text = str( _p.xp ) + "/" + str( PlayerManager.level_requirments[ _p.level ] )
	else:
		label_xp.text = "MAX LVL"
	label_attack.text = str( _p.attack )
	label_defense.text = str( _p.defense )
	
	pass
