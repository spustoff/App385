//
//  HomeViewModel.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR/USD", "GBP/USD", "AUD/USD", "USD/CAD", "USD/CHF", "NZD/USD"]
    @Published var currCur = "EUR/USD"
    @AppStorage("currentCurrency") var currentCurrency = ""

    @AppStorage("categories") var categories: [String] = ["Furniture", "Electronics", "Clothes", "Comfort", "Tools"]
    @Published var currentCategory = ""
    
    @Published var ACat: String = ""
    
    @AppStorage("myGroups") var myGroups: [String] = []

    @Published var furCategory: String = ""
    @Published var furTitle: String = ""
    @Published var furDate: String = ""
    @Published var furCost: String = ""
    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isAddCategory: Bool = false
    @Published var isChart: Bool = false

    @Published var furnitures: [FurnitureModel] = []
    @Published var selectedFurniture: FurnitureModel?

    func addFurniture() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "FurnitureModel", into: context) as! FurnitureModel

        loan.furCategory = furCategory
        loan.furTitle = furTitle
        loan.furDate = furDate
        loan.furCost = furCost

        CoreDataStack.shared.saveContext()
    }
    
    func fetchFurnitures() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FurnitureModel>(entityName: "FurnitureModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.furnitures = result.filter{($0.furCategory ?? "") == currentCategory}
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.furnitures = []
        }
    }
}
