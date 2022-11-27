//
//  ErrorManager.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import Foundation

class ErrorManager: ObservableObject {
    
    static let instance = ErrorManager()
    
    @Published var message = ""
    @Published var shouldDisplay = false
    
}
