@tool
@icon( "res://GUI/dialog_system/icons/cutscene_actor.svg" )
class_name CutsceneActionMove extends CutsceneAction

enum Method { DURATION, SPEED }

@export var timing_duration : Method = Method.DURATION
@export var object_to_move : Node2D
@export var transition_type : Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var easing_type : Tween.EaseType = Tween.EaseType.EASE_IN_OUT
@export_range( 0.0, 10.0, 0.05, "s" ) var move_duration : float = 0.5
@export_range( 10, 1000, 1, "px/s" ) var move_speed : float = 200.0
@export var animation_speed_factor : float = 40.0

var target_location : Vector2 = Vector2.ZERO
var move_direction : Vector2 = Vector2.ZERO
var distance_to_target : float = 0


func _ready() -> void:
	target_location = global_position
	pass


func play() -> void:
	
	pass


func _draw() -> void:
	
	pass
