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
    private var transactionsProvider: TransactionProvider? 
    
    @Published private(set) var transactions: [TransactionModel] = []
    @Published private(set) var category: TransactionModel.Category? = nil
    @Published private(set) var total: Double = 0.0
    
    init(transactionProvider: TransactionProvider? = nil) {
        self.transactionsProvider = transactionProvider
        registerForUpdates()
    }
    
    func togglePin(for transaction: TransactionModel) {
        transactionsProvider?.toggleInclusion(for: transaction)
    }
    
    func updateModel(for category: TransactionModel.Category?) {
        
        self.category = category
        
        defer {
            total = pinnedTotal()
        }
        
        guard let transactionsProvider = transactionsProvider else {
            return
        }
        
        var newTransactions = transactionsProvider.allTransactions
        
        if let category = category {
            newTransactions = newTransactions.filter(by: category)
        }
        
        transactions = newTransactions
    }
    
    private func registerForUpdates() {
        registerForTransactionsUpdates()
        registerForPinnedTransactionsUpdates()
    }
    
    private func registerForTransactionsUpdates() {
        transactionsProvider?.allTransactionsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] transactions in
                self?.updateModel(for: self?.category)
            })
            .store(in: &cancelBag)
    }
    
    private func registerForPinnedTransactionsUpdates() {
        transactionsProvider?.excludedTransactionsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] excludedTransactions in
                self?.total = self?.pinnedTotal() ?? 0.0
            })
            .store(in: &cancelBag)
    }
    
    private func pinnedTotal() -> Double {
        guard let transactionsProvider = transactionsProvider else {
            return 0.0
        }

        return transactions.filter(excluding: transactionsProvider.excludedTransactions).total()
    }
}
