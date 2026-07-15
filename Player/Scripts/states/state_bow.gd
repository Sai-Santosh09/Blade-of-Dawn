class_name StateBow extends State

const ARROW = preload("res://Interactables/arrow/arrow.tscn")

@onready var idle : State = $"../Idle"

var direction : Vector2 = Vector2.ZERO
var next_state : State = null



func _ready():
	pass # Replace with function body.


func Enter() -> void:
	player.UpdateAnimation( "bow" )
	player.animation_player.animation_finished.connect( _on_animation_finished )
	direction = player.direction
	direction = player.cardinal_direction
	
	var arrow := ARROW.instantiate()
	player.add_sibling( arrow )
	arrow.global_position = player.global_position + ( direction * 32 )
	arrow.fire( direction )
	pass


func Exit() -> void:
	player.animation_player.animation_finished.disconnect( _on_animation_finished )
	next_state = null
	pass


func Process( _delta : float ) -> State:
	player.velocity = Vector2.ZERO
	return next_state


func Physics( _delta : float ) -> State:
	return  null


func Handleinput( _event : InputEvent ) -> State:
	return null
	

func _on_animation_finished( anim_name : String ) -> void:
	next_state = idle
	pass
