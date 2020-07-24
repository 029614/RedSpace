extends Node2D


var system_name:String
var system_id:int
var system_position:Vector2
var system_govt:int
var system_desc:String
var system_connections = []

var reciever = null #Who to send input events to


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Area2D_input_event(viewport, event, shape_idx):
    pass
