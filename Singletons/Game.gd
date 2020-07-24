extends Node

# ------ Save Game Information ------ #
var player_name:String
var game_name:String
var date_created:String
var last_played:String
var play_time:String
var mod_list = {
    "Mod_Name":{
        "Mod_Name":"Name",
        "Mod_ID":0,
        "Mod_version":0,
        "Mod_Dependencies":['mod_id']
       }
   }
var game_version:String


# ------ Game State Variables ------ #
var current_system = null



# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
