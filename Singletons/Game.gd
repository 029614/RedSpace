extends Node

# ------ Save Game Information ------ #
var player_name:String
var player_id:int
var player_ref
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
var party = []
var game_version:String


# ------ Game State Variables ------ #
var current_system = null


# ------ Core Game Data ------ #
var starmap = {}

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func import_stars():
    var cfg = ConfigFile.new()
    var err = cfg.load("res://Core/starmap.cfg")
    if err != OK:
        print("Core load error: ", err)
    else:
        var sections = cfg.get_sections()
        for p in sections:
            starmap[p] = {
                'name':cfg.get_value(p, 'name'),
                'id':cfg.get_value(p, 'id'),
                'government':cfg.get_value(p, 'government'),
                'position':cfg.get_value(p, 'position'),
                'connections':cfg.get_value(p, 'connections'),
                'description':cfg.get_value(p, 'description'),
                'planets':cfg.get_value(p, 'planets'),
               }
        return "Import Complete: Stars Loaded!"
