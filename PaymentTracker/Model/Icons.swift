//
//  Icons.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/25/22.
//

import SwiftUI

enum Icons: String, CaseIterable, Identifiable {
    
    var id: String { self.rawValue }
    
    case none = "circle.slash"
    case house
    case houseAndFlag = "house.and.flag"
    case car
    case airplane
    case bus
    case ferry
    case bicycle
    case scooter
    case sailboat
    case fuelpump
    case lightbulb
    case bed = "bed.double"
    case dumbbell
    case gamecontroller
    case pawprint
    case camera
    case display = "display.2"
    case pc
    case iphone = "iphone.rear.camera"
    case headphones
    case magicmouse
    case creditcard
    case ticket
    
}
