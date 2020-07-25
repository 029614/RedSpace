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
    var tex = ImageTexture.new()
    tex.load(path)
    $Sprite.set_texture(tex)
