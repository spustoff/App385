//
//  DocumentsViewModel.swift
//  App385
//
//  Created by IGOR on 11/03/2024.
//

import SwiftUI
import CoreData

final class DocumentsViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR/USD", "GBP/USD", "AUD/USD", "USD/CAD", "USD/CHF", "NZD/USD"]
    @Published var currCur = "EUR/USD"
    @AppStorage("currentCurrency") var currentCurrency = ""

    @Published var categories: [String] = ["Furniture", "Electronics", "Clothes", "Comfort", "Tools"]
    @Published var currentCategory = ""
    
    @AppStorage("myGroups") var myGroups: [String] = []

    @Published var docTitle: String = ""
    @Published var docNumber: String = ""

    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isCurrencies: Bool = false
    @Published var isChart: Bool = false

    @Published var docs: [DocModel] = []
    @Published var selectedDoc: DocModel?

    func addDoc() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "DocModel", into: context) as! DocModel

        loan.docTitle = docTitle
        loan.docNumber = docNumber


        CoreDataStack.shared.saveContext()
    }
    
    func fetchDocs() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<DocModel>(entityName: "DocModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.docs = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.docs = []
        }
    }
}
