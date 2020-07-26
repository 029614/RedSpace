extends Node2D


var system_id
var system_dict


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func build_sys(id):
    system_id = id
    for star in Game.starmap.values():
        if star['id'] == system_id:
            system_dict = star
    for planet in system_dict['planets'].values():
        create_planet(planet)


func create_planet(planet_info):
    var p = load("res://Lobby/SceneAssets/PlanetBase.tscn")
    var newp = p.instance()
    newp.planet_name = planet_info['name']
    newp.planet_id = planet_info['id']
    newp.planet_govt = planet_info['govt']
    newp.planet_desc = planet_info['desc']
    newp.planet_info = planet_info
    newp.set_sprite('res://Core' + planet_info['sprite_path'])
    $Bodies.add_child(newp)
    newp.set_scale(planet_info['size'])
    newp.global_position = planet_info['pos']
    Game.current_system_planets.append(newp)
