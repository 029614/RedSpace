extends Node2D


var planet_name:String
var planet_govt:int
var planet_desc:String
var planet_id:int

var planet_info = {}

onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func set_sprite(path):
    $Sprite.set_texture(load(path))


func _on_Area2D_body_entered(body):
    print('body entered!')


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
    print('body shape entered!')
