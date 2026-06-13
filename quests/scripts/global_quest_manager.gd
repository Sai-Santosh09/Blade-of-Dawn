#QUEST MANAGER - GLOBAL SCRIPT
extends Node

signal quest_updated( q )

const QUEST_DATA_LOCATION : String = "res://quests/"

var quests : Array[ Quest ]
var current_quests : Array = []


func _ready() -> void:
	#gather all the quests
	gather_quest_data()
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		
		update_quest("Short Quest", "")
		update_quest("Find the Flute", "", true)
		update_quest("Long Quest", "step 1")
		update_quest("Long Quest", "step 2")
		print( "Quests : ", current_quests )
		pass
	pass


func gather_quest_data() -> void:
	#gather all the quests and add it in the quests Array
	var quest_files : PackedStringArray = DirAccess.get_files_at( QUEST_DATA_LOCATION )
	quests.clear()
	for q in quest_files:
		quests.append( load( QUEST_DATA_LOCATION + "/" + q ) as Quest )
	print( "Quest Count: " ,quests.size() )
	pass


#Update the status of quests
func update_quest( _title : String, _completed_step : String = "", _is_complete : bool = false ) -> void:
	var quest_index : int = get_quest_index_by_title( _title )
	if quest_index == -1:
		# Quest was not found - add it into current quests Array
		var new_quest : Dictionary = { 
				title = _title, 
				is_complete = _is_complete, 
				completed_steps = [] 
		}
		
		if _completed_step != "":
			new_quest.completed_steps.append( _completed_step )
		
		current_quests.append( new_quest )
		quest_updated.emit( new_quest )
		
		# display some kind of notification to show quest activation
		pass
	else:
		# Quest was found, update it
		var q = current_quests[ quest_index ]
		if _completed_step != "" and q.completed_steps.has( _completed_step ) == false:
			q.completed_steps.append( _completed_step )
			pass
		q.is_complete = _is_complete
		
		quest_updated.emit( q )
		
		# Display smth to show that quest is completed
		if q.is_complete == true:
			var quest_resourse : Quest = find_quest_by_title( _title )
			if quest_resourse != null:
				disperse_quest_rewards( quest_resourse )
			else:
				push_warning("No Quest resourse found for: " + _title)
	pass



func disperse_quest_rewards( _q : Quest ) -> void:
	#Give XP and item rewards
	PlayerManager.reward_xp( _q.reward_xp )
	
	for i in _q.reward_items:
		PlayerManager.INVENTORY_DATA.add_item( i.item, i.quantity )
	pass


# Provide a quest and return the current ones
func find_quest( _quest : Quest ) -> Dictionary:
	for q in current_quests:
		if q.title.to_lower() == _quest.title.to_lower():
			return q
	return { title = "not found", is_complete = false, completed_steps = [''] }


# Takes title to find the associated quests
func find_quest_by_title( _title : String ) -> Quest:
	for q in quests:
		if q.title.to_lower() == _title.to_lower():
			return q
	return null


# Find quests by title name and return the index of the current quest Array
func get_quest_index_by_title( _title : String ) -> int:
	for i in current_quests.size():
		if current_quests[ i ].title.to_lower() == _title.to_lower() :
			return i 
	return -1


func sort_quests() -> void:
	var active_quests : Array = []
	var completed_quests : Array = []
	for q in current_quests:
		if q.is_complete:
			completed_quests.append( q )
		else:
			active_quests.append( q )
	
	active_quests.sort_custom( sort_quests_ascending )
	completed_quests.sort_custom( sort_quests_ascending )
	
	current_quests = active_quests
	current_quests.append_array( completed_quests )
	
	pass


func sort_quests_ascending( a , b ):
	if a.title < b.title:
		return true
	return false
