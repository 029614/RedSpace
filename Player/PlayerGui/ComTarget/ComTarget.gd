extends Control


var target = null


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func target(targ:Object):
    if targ == null:
        $Panel2/VBoxContainer/targetImage.hide()
        $Panel2/VBoxContainer/targetStatus.hide()
        $Panel2/VBoxContainer/actionList.hide()
        $Panel2/VBoxContainer/labelName.hide()
    else:
        target = targ
        image(targ.ship.sprite_path)
        information(targ.get_parent().get_parent().player_name)
        
        $Panel2/VBoxContainer/targetImage.show()
        $Panel2/VBoxContainer/targetStatus.show()
        $Panel2/VBoxContainer/actionList.show()
        $Panel2/VBoxContainer/labelName.show()


func image(path):
    $Panel2/VBoxContainer/targetImage.set_texture(load(path))

func information(tname = 'Unknown', shields = 'Unknown', armour = 'Unknown'):
    $Panel2/VBoxContainer/targetStatus/labelShields.text = 'Shields: ' + shields
    $Panel2/VBoxContainer/targetStatus/labelArmour.text = 'Armour: ' + armour
    $Panel2/VBoxContainer/labelName.text = 'Name: ' + tname
