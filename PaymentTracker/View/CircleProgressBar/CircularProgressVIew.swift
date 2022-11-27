//
//  CircularProgressVIew.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import SwiftUI

struct CircularProgressVIew: View {
    
    let progress: Double
    let color: Color
    let lineWidth: Double
    
    var body: some View {
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color,
                        style:
                            StrokeStyle(
                                lineWidth: lineWidth,
                                lineCap: .round))
                .animation(.easeOut, value: progress)
                .rotationEffect(.degrees(-90))
  
    }
}

struct CircularProgressVIew_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressVIew(progress: 0.45,
                             color: .red,
                             lineWidth: 22)
            .frame(width: 200, height: 200)
    }
}

