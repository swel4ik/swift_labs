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

protocol ShipProtocol {
    var type: Int {get}
    var coordinate: (Int, Int) {get}
    var position_type: String {get}
}

class Ship: ShipProtocol {
    var type: Int
    var coordinate: (Int, Int)
    var position_type: String
    init(type: Int, coordinate: (Int, Int), position_type: String){
        self.type = type
        self.coordinate = coordinate
        self.position_type = position_type
    }
}
