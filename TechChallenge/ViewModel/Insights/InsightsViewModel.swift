//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 23/05/2022.
//

import Foundation
import Combine

class InsightsViewModel: ObservableObject {
    
    private var cancelBag = Set<AnyCancellable>()
    private var transactionsProvider: TransactionProvider?

    @Published var categoriesTotalMap: [TransactionModel.Category: Double] = [:]
    
    var ringViewModel = RingViewModel()
    
    init(transactionProvider: TransactionProvider? = nil) {
        self.transactionsProvider = transactionProvider
        registerForUpdates()
    }
    
    private func registerForUpdates() {
        registerForTransactionsUpdates()
        registerForPinnedTransactionsUpdates()
    }
    
    private func registerForTransactionsUpdates() {
        
        transactionsProvider?.allTransactionsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] transactions in
                self?.updateModel()
            })
            .store(in: &cancelBag)
    }
    
    private func registerForPinnedTransactionsUpdates() {
        transactionsProvider?.excludedTransactionsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] excludedTransactions in
                self?.updateModel()
            })
            .store(in: &cancelBag)
    }
    
    private func updateModel() {
        
        guard let transactions = transactionsProvider?.allTransactions,
              let excludingTransactions = transactionsProvider?.excludedTransactions else {
            return
        }
        
        categoriesTotalMap = TransactionModel.Category.allCases.reduce(into: [TransactionModel.Category : Double]()) { map, category in
            map[category] = transactions.filter(excluding: excludingTransactions).filter(by: category).total()
        }
        
        ringViewModel.updateModel(for: categoriesTotalMap)        
    }
}
