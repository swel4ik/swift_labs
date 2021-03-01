//
//  Ship.swift
//  WaterFight.vol1
//
//  Created by Dmitry Zadorozhniy on 25.02.2021.
//

import Foundation

enum ShipLevel: Int {
    case single = 1
    case double
    case triple
    case ultra
}

enum PositionType {
    case vertical
    case horizonal
}

protocol ShipProtocol {
    var level: ShipLevel {get}
    var coordinate: (Int, Int) {get}
    var position_type: PositionType {get}
}

class Ship: ShipProtocol {
    var level: ShipLevel
    var coordinate: (Int, Int)
    var position_type: PositionType
    init(level: ShipLevel, coordinate: (Int, Int), position_type: PositionType){
        self.level = level
        self.coordinate = coordinate
        self.position_type = position_type
    }
}
