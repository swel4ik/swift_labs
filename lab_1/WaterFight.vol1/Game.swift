//
//  Game.swift
//  WaterFight.vol1
//
//  Created by Dmitry Zadorozhniy on 27.02.2021.
//

import Foundation


protocol GameProtocol {
    var players: [Player] {get set}
    func start()
}


// Delegates

 protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func chooseWinner(_ game: Game)
}

// Default Implementation

extension GameDelegate {
     func gameDidStart(_ game: Game) {
        print("Игра между \(game.players[0].name) и \(game.players[1].name) началась!")
    }
    
    func chooseWinner(_ game: Game, winner: Int) {
        print("\(game.players[winner].name) is a winner!")
    }
}
    

class Game : GameProtocol{
    var players: [Player]
    init(players: [Player]) {
        self.players = players
    }
    var delegate: GameDelegate?
    func start() {
        var opponent_1 = self.players[1]
        delegate?.gameDidStart(self)
        main_loop: while (self.players[0].healths != 0) || (self.players[1].healths != 0) {
            for player in self.players {
                if player.name == self.players[0].name {opponent_1 = self.players[1]}
                else {opponent_1 = self.players[0]}
                for point in player.possible_moves {
                    if player.shoot(point: point, to: opponent_1) {
                        if opponent_1.healths <= 0 {break main_loop}
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
        if self.players[1].healths <= 0 {delegate?.chooseWinner(self, winner: 0)}
        else {delegate?.chooseWinner(self, winner: 1)}
        
}
}
