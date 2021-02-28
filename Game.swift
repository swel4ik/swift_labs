//
//  Game.swift
//  WaterFight.vol1
//
//  Created by Dmitry Zadorozhniy on 27.02.2021.
//

import Foundation


protocol GameProtocol {
    var players: [Player] {get set}
    var opponent: Player {get set}
    func start()
}

class Game : GameProtocol{
    var players: [Player]
    var opponent: Player
    init(players: [Player]) {
        self.players = players
        self.opponent = players[1]
    }
    func start() {
        print("Игра между \(self.players[0].name) и \(self.players[1].name) началась!")
        main_loop: while (self.players[0].healths != 0) || (self.players[1].healths != 0) {
            for player in self.players {
                if player.name == self.players[0].name {self.opponent = self.players[1]}
                else {self.opponent = self.players[0]}
                for point in player.possible_moves {
                    if player.shoot(point: point, to: self.opponent) {
                        if self.opponent.healths <= 0 {break main_loop}
                        player.possible_moves.removeFirst()
                        continue
                    }
                    else {
                        player.possible_moves.removeFirst()
                        break
                }
        }
            
    }
}
        if self.players[1].healths <= 0 {print("\(self.players[0].name) is a winner!")}
        else {print("\(self.players[1].name) is a winner!")}
        
}
}
