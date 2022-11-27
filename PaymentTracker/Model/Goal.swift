//
//  Goal.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import Foundation

struct Goal: Identifiable {
    
    let id: Int
    let name: String
    let iconName: String
    let goalTotal: Double
    let totalPaid: Double
    let monthlyPayment: Double
    let interest: Double
    
    
    var progress: Double {
        return goalTotal / totalPaid
    }
    
    //MARK: - Init from Code
    
    init(id: Int = 0,
         name: String = "",
         iconName: String = "",
         goalTotal: Double = 0,
         totalPaid: Double = 0,
         monthlyPayment: Double = 0,
         interest: Double = 0) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.goalTotal = goalTotal
        self.totalPaid = totalPaid
        self.monthlyPayment = monthlyPayment
        self.interest = interest
    }
 
    
    //MARK: - Init From Core Data
    
    init(_ cdGoal: CDGoal) {
        self.id = Int(cdGoal.id)
        self.name = cdGoal.name ?? ""
        self.iconName = cdGoal.iconName ?? ""
        self.goalTotal = cdGoal.goalTotal
        self.totalPaid = cdGoal.totalPaid
        self.monthlyPayment = cdGoal.monthlyPayment
        self.interest = cdGoal.interest
    }
}
