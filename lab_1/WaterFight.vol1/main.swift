//
//  main.swift
//  WaterFight.vol1
//
//  Created by Dmitry Zadorozhniy on 25.02.2021.
//

import Foundation

let single = ShipLevel.single
let double = ShipLevel.double
let triple = ShipLevel.triple
let ultra = ShipLevel.ultra


let levels = [single]
let coordinates = [(0, 5)]
let position_types = [PositionType.vertical]


var player_1 = Player(name: "Misha")
player_1.create_ships(list_of_levels: levels, list_of_coordinates: coordinates, list_of_pos_types: position_types)
player_1.initialize_ships()

var player_2 = Player(name: "Ivan")
player_2.create_ships(list_of_levels: levels, list_of_coordinates: coordinates, list_of_pos_types: position_types)
player_2.initialize_ships()

let game = Game(players: [player_1, player_2])
game.start()
