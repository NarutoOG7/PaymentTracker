//
//  BasicGridItem.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/24/22.
//

import Foundation

struct BasicGridItem: Identifiable {
    
    let id: Int
    let isBlank: Bool
    let goal: Goal?
}
