//
//  Player .swift
//  WaterFight.vol1
//
//  Created by Dmitry Zadorozhniy on 25.02.2021.
//

import Foundation

// Protocol

protocol PlayerProtocol {
    var name: String {get}
    var healths: Int {get set}
    var field: Array<Array<Int>> {get}
    var ships: [Ship] {get set}
    var possible_moves: [(Int, Int)] {get set}
    func shoot(point: (Int, Int), to: Player) -> Bool
}

class Player: PlayerProtocol {
    var name: String
    var healths: Int
    var field: Array<Array<Int>>
    var ships: [Ship]
    var possible_moves: [(Int, Int)]
    init(name: String) {
        self.name = name
        self.healths = 1
        self.field = Array(repeating:Array(repeating: 0, count: 10), count: 10)
        self.ships = []
        self.possible_moves = []
        for i in 0..<self.field.count {
            for j in 0..<self.field[0].count {
                self.possible_moves.append((i, j))
            }
        }
        self.possible_moves = self.possible_moves.shuffled()
    }
    
    func create_ships(list_of_types: [Int], list_of_coordinates: [(Int, Int)], list_of_pos_types: [String]) {
        for i in 0...list_of_coordinates.count-1 {
            let new_ship = Ship(type: list_of_types[i], coordinate: list_of_coordinates[i], position_type: list_of_pos_types[i])
            self.ships.append(new_ship)
        }
    }
    
    func initialize_ships() {
        for ship in self.ships{
            if ship.position_type == "V" {
                let min_ind = ship.coordinate.0 - ship.type + 1
                for i in min_ind...ship.coordinate.0 {
                    self.field[i][ship.coordinate.1] = 1
                }
            }
            else if ship.position_type == "H" {
                let max_ind = ship.coordinate.1 + ship.type - 1
                for i in ship.coordinate.1...max_ind {
                    self.field[ship.coordinate.0][i] = 1
                }
            }
        }
    }
    
    func shoot(point: (Int, Int), to: Player) -> Bool {
        print("\(self.name) стреляет в \(point)")
        if to.field[point.0][point.1] == 0 {
            print("\(self.name) промазал!")
            return false
        }
        else {
            print("\(self.name) попал!")
            to.healths -= 1
            to.field[point.0][point.1] = 0
            return true
        }
    }
}
