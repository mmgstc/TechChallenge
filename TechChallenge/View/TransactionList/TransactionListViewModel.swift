//
//  TransactionListViewModel.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 22/05/2022.
//

import Foundation
import Combine

class TransactionListViewModel: ObservableObject {
    
    private var cancelBag = Set<AnyCancellable>()
    private var allTransactions: [TransactionModel]
    
    @Published var transactions: [TransactionModel] = []
    @Published var category: TransactionModel.Category? = nil
    @Published var total: Double = 0.0
    
    init(allTransactions: [TransactionModel] = ModelData.sampleTransactions) {
        self.allTransactions = allTransactions
        updateModel(for: category)
    }
    
    func bind(_ filter: AnyPublisher<TransactionModel.Category?,Never>) {
        filter
            .eraseToAnyPublisher()
            .sink { category in
                self.updateModel(for: category)
            }
            .store(in: &cancelBag)
    }
    
    private func updateModel(for category: TransactionModel.Category?) {
        
        self.category = category
        
        defer {
            total = transactions.total()
        }
        
        guard let category = category else {
            transactions = allTransactions
            return
        }
        
        transactions = allTransactions.filter(by: category)
    }
}
