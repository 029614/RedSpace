extends Control


var target = null


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func target(targ:Object, targ_info):
    print('target', targ)
    if targ == null:
        $Panel2/VBoxContainer/targetImage.hide()
        $Panel2/VBoxContainer/targetStatus.hide()
        $Panel2/VBoxContainer/actionList.hide()
        $Panel2/VBoxContainer/labelName.hide()
    else:
        print('target: ', targ)
        print('target name: ', targ.get_parent().get_parent().test_var)
        target = targ
        print('sprite path: ', targ.sprite_path)
        image(targ.sprite_path)
        information(targ_info['name'])
        
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
