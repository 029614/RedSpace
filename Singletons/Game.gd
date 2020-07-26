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
var current_system = 0
var current_system_data = {}
var current_system_planets = []
var current_system_ships = []


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


func change_system(id):
    for s in starmap.values():
        if s['id'] == id:
            current_system = id
            current_system_data = s


func get_closest_planet(pos:Vector2):
    if current_system_planets.size() == 0:
        return 'No planets found'
    else:
        print(current_system_planets)
        var closest_planet = null
        for planet in current_system_planets:
            if closest_planet == null:
                closest_planet = planet
            else:
                if planet.global_position.distance_to(pos) < closest_planet.global_position.distance_to(pos):
                    closest_planet = planet
        return closest_planet


func get_planets_in_system():
    return current_system_planets


func get_planet_by_id(id):
    if current_system_planets.size() == 0:
        return 'No planets found'
    else:
        for planet in current_system_planets:
            if planet.planet_id == id:
                return planet


func get_ships_in_system():
    return current_system_ships


func get_closest_ship():
    pass


