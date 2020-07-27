extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func target_planet(planet):
    if planet != null:
        $Panel2/VBoxContainer/texturePlanetSprite.set_texture(load('res://Core' + planet.planet_info['sprite_path']))
        $Panel2/VBoxContainer/labelPlanetName.set_text(planet.planet_info['name'])
        $Panel2/VBoxContainer/labelPlanetName.show()
        $Panel2/VBoxContainer/texturePlanetSprite.show()
    elif planet == null:
        $Panel2/VBoxContainer/labelPlanetName.hide()
        $Panel2/VBoxContainer/texturePlanetSprite.hide()
        
