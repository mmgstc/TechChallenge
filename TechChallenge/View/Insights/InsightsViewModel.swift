//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 23/05/2022.
//

import Foundation
import Combine

class InsightsViewModel: ObservableObject {
    
    @Published var categoriesTotalMap: [TransactionModel.Category: Double] = [:]
    
    var ringViewModel = RingViewModel()
    
    init(allTransactions: [TransactionModel] = ModelData.sampleTransactions) {
        
        defer {
            updateModel(for: allTransactions)
        }
    }
    
    private func updateModel(for transactions: [TransactionModel]) {
        defer {
            ringViewModel.updateModel(for: categoriesTotalMap)
        }
        
        categoriesTotalMap = TransactionModel.Category.allCases.reduce(into: [TransactionModel.Category : Double]()) { map, category in
            map[category] = transactions.filter(by: category).total()
        }
    }
}
