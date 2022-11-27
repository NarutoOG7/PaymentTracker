//
//  HomeScreen.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import SwiftUI
import UserGreeting

struct HomeScreen: View {
    
    let images = K.ImageNames.self
    
    let geo: GeometryProxy
        
    var layout: [GridItem] {
        let adaptiveColumn = GridItem(.adaptive(minimum: geo.size.width / 2.3))
        return [
            adaptiveColumn,
            adaptiveColumn
        ]
    }
    
    @State var addNewIsShowing = false
    
    @ObservedObject var goalsManager: GoalsManager
    @ObservedObject var gridManager: GridManager
    
    
    var body: some View {
        VStack {
            HStack {
                menuButton
                addButton
            }
            greeting
            goalsView
            Spacer()
        }
        
        .sheet(isPresented: $addNewIsShowing) {
            NewGoalView()
        }
        
        .task {
            goalsManager.fetchAllGoals()
        }
    }
    
    var greeting: some View {
        GreetingView(
            greetingTextColor: .blue,
            nameTextColor: .red,
            font: .title,
            name: "Spencer")
    }
    
    var goalsView: some View {
        LazyVGrid(columns: layout, spacing: 50) {
            ForEach(goalsManager.allGoals) { goal in
                let progress = goal.totalPaid == 0 ? 0 : goal.goalTotal / goal.totalPaid
                NavigationLink {
                    NewGoalView(
                        iconNameSelection: goal.iconName,
                        nameInput: goal.name,
                        goalInput: String(format: "%.2f", goal.goalTotal),
                        totalPaidInput: String(format: "%.2f", goal.totalPaid),
                        monthlyPaymentInput: String(format: "%.2f", goal.monthlyPayment),
                        interestInput: String(format: "%.2f", goal.interest),
                        shouldShowNameErrorMessage: false,
                        shouldShowGoalErrorMessage: false,
                        shouldShowMonthlyPaymentErrorMessage: false)
                } label: {
                    StackedProgressCircles(
                        circleWidth: geo.size.width / 2.75,
                        progress: progress,
                        lineWidth: 20,
                        iconName: goal.iconName)
                }
//                .onTapGesture {
//                    self.addNewIsShowing = true
//                }
      
            }
        }
        .padding()
    }
    
    func goalsLogic(geo: GeometryProxy) {
        let availableHeight = geo.size.height - 200
        let maxForHeight = availableHeight / 3
        let minCircleHeight = 75
//        switch goals.count {
//            case 0
//            return empty
//            case
//        }
    }
    
    //MARK: - Buttons
    
    var menuButton: some View {
        HStack {
            Button(action: menuTapped) {
                Image(systemName: images.menuIcon)
                    .resizable()
                    .frame(width: 25, height: 20)
            }.padding(.horizontal)
                .padding(.top)
            
            Spacer()
        }
    }
    
    var addButton: some View {
        Button(action: addTapped) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    //MARK: - Methods
    
    private func menuTapped() {
        
    }
    
    private func addTapped() {
        self.addNewIsShowing = true
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            HomeScreen(geo: geo, goalsManager: GoalsManager(allGoals: []), gridManager: GridManager())
        }
    }
}
