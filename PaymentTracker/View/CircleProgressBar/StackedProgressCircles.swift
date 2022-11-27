//
//  StackedProgressCircles.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import SwiftUI

struct StackedProgressCircles: View {
    
    let circleWidth: Double
    let progress: Double
    let lineWidth: Double
    let iconName: String
    
    var body: some View {
        
        ZStack {
            icon
            ZStack {
                innerCircle
                outerCircle
            }
            .shadow(color: .black.opacity(0.35), radius: 5, x: 0, y: 13)
        }
    }
    
    private var icon: some View {
        Image(systemName: iconName)
            .resizable()
            .frame(width: circleWidth / 3, height: circleWidth / 3)
    }
    
    private var innerCircle: some View {
        CircularProgressVIew(
            progress: progress - 0.025,
            color: Color("darkGreen"),
            lineWidth: lineWidth - 5)
        .frame(width: circleWidth - 20,
               height: circleWidth - 20)
        .rotationEffect(.degrees(4))
        
    }
    
    private var outerCircle: some View {
        CircularProgressVIew(
            progress: progress,
            color: Color("green"),
            lineWidth: lineWidth)
        .frame(width: circleWidth,
               height: circleWidth)
    }
}


struct StackedProgressCircles_Previews: PreviewProvider {
    static var previews: some View {
        StackedProgressCircles(
            circleWidth: 250,
            progress: 0,
            lineWidth: 27,
            iconName: "house")
    }
}
