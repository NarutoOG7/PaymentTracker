//
//  DetailScreen.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/26/22.
//

import SwiftUI

struct DetailScreen: View {
    
    let goal: Goal
    
    var body: some View {
        GeometryReader { geo in
            progressView(geo)
        }
    }
    
    private var title: some View {
        Text(goal.name)
            .font(.title)
    }
    
    private func progressView(_ geo: GeometryProxy) -> some View {
        StackedProgressCircles(circleWidth: geo.size.width / 2, progress: goal.progress, lineWidth: 20, iconName: goal.iconName)
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(goal: Goal())
    }
}
