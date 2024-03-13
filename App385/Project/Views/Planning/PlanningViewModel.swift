//
//  PlanningViewModel.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI
import CoreData

final class PlanningViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR/USD", "GBP/USD", "AUD/USD", "USD/CAD", "USD/CHF", "NZD/USD"]
    @Published var currCur = "EUR/USD"
    @AppStorage("currentCurrency") var currentCurrency = ""

    @AppStorage("categories") var categories: [String] = ["Furniture", "Electronics", "Clothes", "Comfort", "Tools"]
    @Published var currentCategory = ""
    
    @AppStorage("myGroups") var myGroups: [String] = []

    @Published var pTitle: String = ""
    @Published var pCategory: String = ""
    @Published var pCost: String = ""
    @Published var pNotes: String = ""
    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isCurrencies: Bool = false
    @Published var isChart: Bool = false

    @Published var items: [PlanningModel] = []
    @Published var selectedItem: PlanningModel?

    func addItem() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PlanningModel", into: context) as! PlanningModel

        loan.pTitle = pTitle
        loan.pCategory = pCategory
        loan.pCost = pCost
        loan.pNotes = pNotes

        CoreDataStack.shared.saveContext()
    }
    
    func fetchItems() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PlanningModel>(entityName: "PlanningModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.items = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.items = []
        }
    }
}

