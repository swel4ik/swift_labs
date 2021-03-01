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

// Delegates

 protocol PlayerDelegate {
    func hit(_ player: Player)
    func missed(_ player: Player)
    func fire(_ from: Player, _ point: (Int, Int))
}

extension PlayerDelegate {
    func hit(_ player: Player) {
        print("\(player.name) попал!")
    }
    func missed(_ player: Player) {
        print("\(player.name) промазал!")
    }
    func fire(_ from: Player, _ point: (Int, Int)) {
        print("\(from.name) стреляет в \(point)")
    }
}

class Player: PlayerProtocol {
    var name: String
    var healths: Int
    var field: Array<Array<Int>>
    var ships: [Ship]
    var possible_moves: [(Int, Int)]
    init(name: String) {
        self.name = name
        self.healths = 0
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
    
    var delegate: PlayerDelegate?
    func create_ships(list_of_levels: [ShipLevel], list_of_coordinates: [(Int, Int)], list_of_pos_types: [PositionType]) {
        for i in 0...list_of_coordinates.count-1 {
            let new_ship = Ship(level: list_of_levels[i], coordinate: list_of_coordinates[i], position_type: list_of_pos_types[i])
            self.healths += new_ship.level.rawValue
            self.ships.append(new_ship)
        }
    }
    
    func initialize_ships() {
        for ship in self.ships{
            if ship.position_type == PositionType.vertical {
                let min_ind = ship.coordinate.0 - ship.level.rawValue + 1
                for i in min_ind...ship.coordinate.0 {
                    self.field[i][ship.coordinate.1] = 1
                }
            }
            else if ship.position_type == PositionType.horizonal {
                let max_ind = ship.coordinate.1 + ship.level.rawValue - 1
                for i in ship.coordinate.1...max_ind {
                    self.field[ship.coordinate.0][i] = 1
                }
            }
        }
    }
    
    func shoot(point: (Int, Int), to: Player) -> Bool {
        delegate?.fire(self, point)
        if to.field[point.0][point.1] == 0 {
            delegate?.missed(self)
            return false
        }
        else {
            delegate?.hit(self)
            to.healths -= 1
            to.field[point.0][point.1] = 0
            return true
        }
    }
}
