//
//  GridManager.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/24/22.
//

import SwiftUI

class GridManager: ObservableObject {
    
    static let instance = GridManager()
    
    @Published var gridItems: [BasicGridItem] = []

}
