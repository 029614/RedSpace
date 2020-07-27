extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ship_catelog = []

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func prepare():
    $Panel2/labelDesc.text = ''
    $Panel2/containerButtons/buttonBuy.text = 'Purchase'
    $Panel2/containerButtons/buttonBuy.disabled = true


func create_ship_list(ships):
    if ship_catelog.size() > 0:
        for ship in ship_catelog:
            ship.queue_free()
        ship_catelog.clear()
    
    if $Panel2/itemShip.get_item_count() > 0:
        $Panel2/itemShip.clear()
        
    if ships.size() > 0:
        for ship in ships:
            var s = load(ship)
            s = s.instance()
            $Panel2/itemShip.add_item(s.ship_class, load(s.sprite_path))
            ship_catelog.append(s)


func _on_itemShip_item_selected(index):
    $Panel2/labelDesc.text = '  ' + ship_catelog[index].ship_desc
    $Panel2/labelDesc.text += '\n'
    $Panel2/labelDesc.text += '\n Class: ' + ship_catelog[index].ship_class
    $Panel2/labelDesc.text += '\n Type: ' + ship_catelog[index].ship_type
    $Panel2/labelDesc.text += '\n Cargo: ' + str(ship_catelog[index].ship_cargo)
    $Panel2/labelDesc.text += '\n Passengers: ' + str(ship_catelog[index].ship_persons)
    $Panel2/labelDesc.text += '\n Crew: ' + str(ship_catelog[index].ship_crew)
    $Panel2/containerButtons/buttonBuy.text = 'Purchase (' + Game.integer_to_currency_format(ship_catelog[index].ship_cost) + ' credits)'
    $Panel2/containerButtons/buttonBuy.disabled = false
