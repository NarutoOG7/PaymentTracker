//
//  NewGoalView.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/24/22.
//

import SwiftUI
import UserInputCell

struct NewGoalView: View {
    
    var isUpdating = false
    var updatingGoalID: Int? = nil
    
    @State var iconNameSelection = ""
    @State var nameInput = ""
    @State var goalInput = ""
    @State var totalPaidInput = ""
    @State var monthlyPaymentInput = ""
    @State var interestInput = ""
    

    @State var shouldShowNameErrorMessage = false
    @State var shouldShowGoalErrorMessage = false
    @State var shouldShowMonthlyPaymentErrorMessage = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            title
            iconPicker
            nameField
            goalView
            totalPaidView
            monthlyPaymentAmtView
            interestView
            doneButton
            deleteButton
        }
        .padding()
    }
    
    private var title: some View {
        VStack {
            Text(isUpdating ? "Update Goal" : "Add New Goal")
                .font(.title)
                .foregroundColor(.blue)
            Spacer()
        }
    }
    
    private var iconPicker: some View {
        HStack {
            Picker(iconNameSelection,
                   selection: $iconNameSelection) {
//                Text("none")
                ForEach(Icons.allCases) { icon in
                        Image(systemName: icon.rawValue)
                }
            }
            
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var nameField: some View {
        UserInputCellView(
            input: $nameInput,
            shouldShowErrorMessage: $shouldShowNameErrorMessage,
            isSecured: .constant(false),
            primaryColor: .red,
            accentColor: .blue,
            thirdColor: .yellow,
            icon: nil,
            title: "Name",
            placeholderText: "",
            font: .subheadline,
            errorMessage: "Name already exists in your current goals.")
    }

    private var goalView: some View {
        UserInputCellView(
            input: $goalInput,
            shouldShowErrorMessage: $shouldShowGoalErrorMessage,
            isSecured: .constant(false),
            primaryColor: .red,
            accentColor: .blue,
            thirdColor: .yellow,
            icon: nil,
            title: "Goal Total",
            placeholderText: "",
            font: .subheadline,
            errorMessage: "Please provide a value.")
            .keyboardType(.decimalPad)
    }
    
    
    private var totalPaidView: some View {
        UserInputCellView(
            input: $totalPaidInput,
            shouldShowErrorMessage: .constant(false),
            isSecured: .constant(false),
            primaryColor: .red,
            accentColor: .blue,
            thirdColor: .yellow,
            icon: nil,
            title: "Total Paid",
            placeholderText: "(optional)",
            font: .subheadline,
            errorMessage: "")
            .keyboardType(.decimalPad)
    }

    
    private var monthlyPaymentAmtView: some View {
        UserInputCellView(
            input: $monthlyPaymentInput,
            shouldShowErrorMessage: $shouldShowMonthlyPaymentErrorMessage,
            isSecured: .constant(false),
            primaryColor: .red,
            accentColor: .blue,
            thirdColor: .yellow,
            icon: nil,
            title: "Monthly payment amount",
            placeholderText: "",
            font: .subheadline,
            errorMessage: "Please provide a value.")
            .keyboardType(.numberPad)
    }
    
    
    private var interestView: some View {
        UserInputCellView(
            input: $interestInput,
            shouldShowErrorMessage: .constant(false),
            isSecured: .constant(false),
            primaryColor: .red,
            accentColor: .blue,
            thirdColor: .yellow,
            icon: nil,
            title: "Interest (as percentage)",
            placeholderText: "Interest (optional)",
            font: .subheadline,
            errorMessage: "Please provide a value.")
        .keyboardType(.decimalPad)
    }
    
    
    //MARK: - Buttons
    
    private var doneButton: some View {
        VStack {
            Spacer()
            Button(action: doneTapped) {
                Text("Done")
                    .font(.title)
                    .padding()
                    .overlay(Capsule().stroke(.red, lineWidth: 3))
            }
            Spacer()
        }
    }
    
    private var deleteButton: some View {
        Button(action: deleteTapped) {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
    }
    
    //MARK: - Methods
    
    private func doneTapped() {

        let goal = goalFromInputs()
        
        PersistenceController.shared.createOrUpdateGoal(goal) { success in
            if success {
                
                GoalsManager.instance.fetchAllGoals()
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
    
    private func deleteTapped() {
            let goal = goalFromInputs()
        PersistenceController.shared.delete(goal) { error in
            self.nameInput = error?.localizedDescription ?? ""
        }
            self.presentationMode.wrappedValue.dismiss()
            GoalsManager.instance.fetchAllGoals()

        
    }
    
    func goalFromInputs() -> Goal {
        let total = Double(goalInput) ?? 0
        let totalPaid = Double(totalPaidInput) ?? 0
        let monthlyPay = Double(monthlyPaymentInput) ?? 0
        let interest = Double(interestInput) ?? 0
        let goal = Goal(
            id: GoalsManager.instance.allGoals.count,
            name: nameInput,
            iconName: iconNameSelection,
            goalTotal: total,
            totalPaid: totalPaid,
            monthlyPayment: monthlyPay,
            interest: interest)
        
        return goal
    }
    
    //MARK: - InputFieldType
    
    enum InputFieldType {
        case icon,
        name,
        total,
        monthlyPayment,
        interest
    }
}

//MARK: - Preview

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(isUpdating: false,
                    updatingGoalID: nil)
    }
}

public extension Binding where Value: Equatable {
    init(_ source: Binding<Value>, deselectTo value: Value) {
        self.init(get: { source.wrappedValue },
                  set: { source.wrappedValue = $0 == source.wrappedValue ? value : $0 }
        )
    }
}
