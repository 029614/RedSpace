extends Node


var system_id:int
var system_info = {}
var players = []
var ships = []
var bodies = []


# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.connect("change_system", self, "changeSystem")
    Signals.connect("update_bodies_in_system", self, "updateBodies")
    Signals.connect("update_players_in_system", self, "updatePlayers")
    Signals.connect("update_ships_in_system", self, "updateShips")
    

func updateSystem():
    updateBodies()
    updatePlayers()
    updateShips(true)


func updateBodies():
    Game.get_planets_in_system()
    

func updatePlayers():
    Game.get_players_in_system()


func updateShips(ships):
    ships = Game.get_ships_in_system()



