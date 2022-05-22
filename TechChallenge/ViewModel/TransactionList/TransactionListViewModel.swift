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
    private var allTransactions: [TransactionModel] = []
    
    @Published var transactions: [TransactionModel] = []
    @Published var category: TransactionModel.Category? = nil
    @Published var total: Double = 0.0
    
    init(transactionProvider: TransactionProvider? = nil) {
        self.transactionsProvider = transactionProvider
        registerForUpdates()
    }
    
    func bind(_ filter: AnyPublisher<TransactionModel.Category?,Never>) {
        filter
            .eraseToAnyPublisher()
            .sink { category in
                self.updateModel(for: category)
            }
            .store(in: &cancelBag)
    }
    
    func togglePin(for transaction: TransactionModel) {
        transactionsProvider?.toggleInclusion(for: transaction)
    }
    
    private func registerForUpdates() {
        registerForTransactionsUpdates()
        registerForPinnedTransactionsUpdates()
    }
    
    private func registerForTransactionsUpdates() {
        
        transactionsProvider?.allTransactionsPublisher
            //.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] transactions in
                self?.allTransactions = transactions
                self?.updateModel(for: self?.category)
            })
            .store(in: &cancelBag)
    }
    
    private func registerForPinnedTransactionsUpdates() {
        transactionsProvider?.excludedTransactionsPublisher
            //.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] excludedTransactions in
                self?.total = self?.pinnedTotal() ?? 0.0
            })
            .store(in: &cancelBag)
    }
    
    private func updateModel(for category: TransactionModel.Category?) {
        
        self.category = category
        
        defer {
            total = pinnedTotal()
        }
        
        guard let category = category else {
            transactions = allTransactions
            return
        }
        
        transactions = allTransactions.filter(by: category)
    }
    
    private func pinnedTotal() -> Double {
        guard let transactionsProvider = transactionsProvider else {
            return 0.0
        }

        return transactions.filter(excluding: transactionsProvider.excludedTransactions).total()
    }
}
