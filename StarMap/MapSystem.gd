extends Button


var system_name:String
var system_id:int
var system_position:Vector2
var system_govt:int
var system_desc:String
var system_connections = []

var reciever = null #Who to send input events to

var _mouse_over = false
var _selected = false

onready var mod = self


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func changeName(new_name):
    $SystemName.text = new_name

func target(condition):
    if condition == true:
        _selected = true
        mod.modulate = Color(0,23,176)
        $SelectIcon.show()
    else:
        _selected = false
        mod.modulate = Color(255,255,255)
        $SelectIcon.hide()


func _on_MapSystem_pressed():
    Signals.emit_signal("system_targeted", system_id)


func _on_MapSystem_mouse_entered():
    if _selected == false:
        mod.modulate = Color(4,242,186)
        $SelectIcon.show()


func _on_MapSystem_mouse_exited():
    if _selected == false:
        $SelectIcon.hide()
        mod.modulate = Color(255,255,255)
