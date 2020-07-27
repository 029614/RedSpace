extends Control


onready var ship_list = $Popups/Shipyard/Panel2/itemShip
var ships = ["res://Ships/Testing/ShipObject.tscn"]
var ship_catelog = []
var menu_popup_state = '_main_menu'
var menu_popup_conditions = ['_main_menu', '_ship_yard', '_outfitter', '_escorts', '_bank', '_trade', '_missions', '_bar']
onready var menu_key = [{'name':'_ship_yard', 'button':$Panel2/rightMenu/VBoxContainer/buttonShipYard, 'menu':$Popups/Shipyard}]




# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func create_menu(planet):
    $Panel2/planetSprite.set_texture(load('res://Core' + planet.planet_info['sprite_path']))
    $Panel2/planetDesc.text = planet.planet_info['desc']


func toggle_menu(button):
    if button == null:
        menu_popup_state = '_main_menu'
        for menu in menu_key:
            menu['button'].disabled = false
            menu['menu'].hide()
    else:
        for menu in menu_key:
            if menu['button'] == button:
                menu['menu'].prepare()
                menu['menu'].show()
                button.disabled = true
                menu_popup_state = menu['name']
            else:
                menu['menu'].show()
                button.disabled = false


func _on_PlanetInterface_popup_hide():
    Signals.emit_signal("launch_player")


func _on_buttonLeave_pressed():
    hide()
    Signals.emit_signal("launch_player")


func _on_buttonShipYard_pressed():
    $Popups/Shipyard.create_ship_list(ships)
    toggle_menu($Panel2/rightMenu/VBoxContainer/buttonShipYard)
    #for menu in $Popups.get_children():
    #    menu.hide()
    #$Popups/Shipyard.show()


func _on_buttonBack_pressed():
    toggle_menu(null)
