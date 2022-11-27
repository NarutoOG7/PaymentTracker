//
//  GoalsManager.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/24/22.
//

import SwiftUI


class GoalsManager: ObservableObject {
    
    static let instance = GoalsManager(allGoals: [])
    
    @Published var allGoals = [Goal]()
    
    @ObservedObject var gridManager = GridManager.instance
    
    @ObservedObject var errorManager = ErrorManager.instance
    
    init(allGoals: [Goal], gridManager: GridManager = GridManager.instance, errorManager: ErrorManager = ErrorManager.instance) {
        self.allGoals = allGoals
        self.gridManager = gridManager
        self.errorManager = errorManager
        fetchAllGoals()
    }
    
    
    func fetchAllGoals() {
        self.allGoals = []
        
        PersistenceController.shared.getAllGoals { goals in
            
            self.allGoals = goals ?? []
            
        } onError: { error in
            self.errorManager.message = error.localizedDescription
            self.errorManager.shouldDisplay = true
        }

    }
    
}
