//
//  PersistenceController.swift
//  PaymentTracker
//
//  Created by Spencer Belton on 11/23/22.
//

import SwiftUI
import CoreData


struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    @ObservedObject var errorManager = ErrorManager.instance
        
    init() {
        container = NSPersistentContainer(name: "TrackerData")
        container.loadPersistentStores { description, error in
            if let error = error {
                ErrorManager.instance.message = error.localizedDescription
                ErrorManager.instance.shouldDisplay = true
            }
        }
        
        self.context = container.viewContext
        
        deleteAll()
    }
    
    func deleteAll(completion: @escaping (Error?) -> () = {_ in}) {
        
        do {
//            let context = container.viewContext
            
            
            let request : NSFetchRequest<CDGoal> = CDGoal.fetchRequest()
            let trips = try context.fetch(request)
            
            for trip in trips {
                context.delete(trip)
            }
            save(context, completion: completion)
        } catch {
            print("Error fetching request: \(error)")
        }
    }
    
    
    func save(_ context: NSManagedObjectContext, completion: @escaping (Error?) -> () = {_ in}) {
        
        context.perform {
            
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ goal: Goal, completion: @escaping (Error?) -> () = {_ in}) {
        self.getAllCDGoals { cdGoals in
            if let goalToDelete = cdGoals?.first(where: { $0.id == goal.id }) {
                
                context.delete(goalToDelete)
                save(context, completion: completion)
            }
        } onError: { error in
            completion(error)
        }

    }
    
    func createOrUpdateGoal(_ goal: Goal, onSuccess: @escaping (Bool) -> () = {_ in}) {
        
        context.perform {
            do {
                
                let request: NSFetchRequest<CDGoal> = CDGoal.fetchRequest()
                request.predicate = NSPredicate(format: "name == %@", goal.name)
                
                let numberOfRecords = try context.count(for: request)
                
                if numberOfRecords == 0 {
                    
                   let _ = assignDataToCD(context: context,
                                   goal: goal)
                    
                } else {
                    let goals = try context.fetch(request)
                    if let goalToUpdate = goals.first {
                        
                        let _ = updateCDGoal(cdGoal: goalToUpdate, goal: goal)
                    }
                }
                
                self.save(context) { error in
                    if let error = error {
                        self.errorManager.message = "Failed to save your trip. Please try again or contact support."
                        self.errorManager.shouldDisplay = true
                    } else {
                        onSuccess(true)
                    }
                }
                
            } catch {
                self.errorManager.message = "Failed to save your trip. Please try again or contact support."
                self.errorManager.shouldDisplay = true
            }
        }
    }
    
    func updateCDGoal(cdGoal: CDGoal, goal: Goal) {
        cdGoal.id = Int16(goal.id)
        cdGoal.name = goal.name
        cdGoal.iconName = goal.iconName
        cdGoal.goalTotal = goal.goalTotal
        cdGoal.totalPaid = goal.totalPaid ?? 0
        cdGoal.monthlyPayment = goal.monthlyPayment
        cdGoal.interest = goal.interest
        
    }
    
    
    func assignDataToCD(context: NSManagedObjectContext, goal: Goal) -> CDGoal {
        let cdGoal = CDGoal(context: context)
        updateCDGoal(cdGoal: cdGoal, goal: goal)
        return cdGoal
    }
    
    func getAllGoals(completion: @escaping([Goal]?) -> Void, onError: @escaping(Error) -> Void) {
        
        do {
            
            let request: NSFetchRequest<CDGoal> = CDGoal.fetchRequest()
            let cdGoals = try context.fetch(request)
            
            var goals: [Goal] = []
            
            for cdGoal in cdGoals {
                let goal = Goal(cdGoal)
                goals.append(goal)
            }
            
            completion(goals)
            
                        
        } catch {
            onError(error)
        }
                    

        

    }
    
    func getAllCDGoals(completion: @escaping([CDGoal]?) -> Void, onError: @escaping(Error) -> Void) {
        do {
            
            let request: NSFetchRequest<CDGoal> = CDGoal.fetchRequest()
            let cdGoals = try context.fetch(request)
            
            completion(cdGoals)
            
        } catch {
            onError(error)
        }
    }
}


