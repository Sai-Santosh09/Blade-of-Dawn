class_name State_Grapple extends State

@onready var idle : State_Idle = $"../Idle"
@onready var grapple_hook : Node2D = %GrappleHook
@onready var nine_patch_rect : NinePatchRect = $"../../GrappleHook/NinePatchRect"
@onready var chain_audio_player : AudioStreamPlayer2D = $"../../GrappleHook/AudioStreamPlayer2D"


@export var grapple_distance : float = 100.0
@export var grapple_speed : float = 200.0

@export_group("Audio SFX")
@export var grapple_fire_audio : AudioStream
@export var grapple_stick_audio : AudioStream
@export var grapple_bounce_audio : AudioStream


var collision_distance : float
var collision_type : int = 0
var nine_patch_size : float = 25.0

var tween : Tween

var next_state : State = null

var positions : Array[ Vector3 ] = [
	Vector3( 8.0, -20.0, 180.0 ),
	Vector3( 8.0, -10.0, 0.0 ),
	Vector3( -10.0, -15.0, 90.0 ),
	Vector3( 10.0, -15.0, -90.0 ),
]
var pop_map : Dictionary = {
	Vector2.UP : 0,
	Vector2.DOWN : 1,
	Vector2.LEFT : 2,
	Vector2.RIGHT : 3,
}


func init() -> void:
	
	pass


func Enter() -> void:
	print("Grpple State!!")
	pass




func Exit() -> void:
	pass




func Process( _delta : float ) -> State:
	return null



func Physics( _delta : float ) -> State:
	return  null



func Handleinput( _event : InputEvent ) -> State:
	return null
