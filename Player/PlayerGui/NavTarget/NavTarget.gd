extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func target_planet(planet):
    var it = ImageTexture.new()
    it.load('res://Core' + planet.planet_info['sprite_path'])
    $Panel2/VBoxContainer/texturePlanetSprite.set_texture(it)
    $Panel2/VBoxContainer/labelPlanetName.set_text(planet.planet_info['name'])
    $Panel2/VBoxContainer/labelPlanetName.show()
