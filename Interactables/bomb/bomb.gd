class_name ThrowableBomb extends Throwable


@export_category( "Bomb Settings" )
@export_range( 1.0, 10.0, 0.1, "s" ) var fuse_duration : float = 4.0

@export_category( "Bounce Settings" )
@export_range( 0.1, 0.9, 0.05 ) var bounciness : float = 0.5
@export_range( 1, 10, 1 ) var max_bounces : int = 5


var bounce_count : int = 0
var og_throw_speed : float = 0

@onready var explosion_sprite: Sprite2D = $"../ExplosionSprite"


func _ready() -> void:
	super()
	og_throw_speed = throw_speed
	hurt_box.damage = 0
	animation_player.queue( "explode" )
	animation_player.animation_changed.connect( _on_animation_changed )
	animation_player.speed_scale = animation_player.current_animation_length / fuse_duration
	pass


func _physics_process( delta: float ) -> void:
	super( delta )
	explosion_sprite.position = object_sprite.position
	pass


func _on_animation_changed( _old_name : String, _new_name : String ) -> void:
	animation_player.speed_scale = 1.0
	pass


func hit_ground() -> void:
	bounce_count += 1
	
	if bounce_count <= max_bounces:
		object_sprite.position.y = ground_height - 1
		vertical_velocity *= -1 * bounciness
		throw_speed *= bounciness
	else:
		set_physics_process( false )
		hurt_box.set_deferred( "monitoring" , false )
		hurt_box.did_damage.disconnect( did_damage )
		wall_detect.body_entered.disconnect( _on_body_entered )
	pass
