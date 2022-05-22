//
//  AppModel.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 23/05/2022.
//

import Foundation
import Combine

protocol TransactionProvider {
    var allTransactions: [TransactionModel] { get }
    
    var allTransactionsPublished: Published<[TransactionModel]> { get }
    
    var allTransactionsPublisher: Published<[TransactionModel]>.Publisher { get }
    
    var excludedTransactions: [TransactionModel] { get }
    
    var excludedTransactionsPublished: Published<[TransactionModel]> { get }
    
    var excludedTransactionsPublisher: Published<[TransactionModel]>.Publisher { get }
    
    func toggleInclusion(for transaction: TransactionModel)
    
    func update()
}

class AppModel: ObservableObject, TransactionProvider {
    
    @Published var allTransactions: [TransactionModel] = []
    var allTransactionsPublished: Published<[TransactionModel]> { _allTransactions }
    var allTransactionsPublisher: Published<[TransactionModel]>.Publisher { $allTransactions }
    
    @Published var excludedTransactions: [TransactionModel] = []
    var excludedTransactionsPublished: Published<[TransactionModel]> { _excludedTransactions }
    var excludedTransactionsPublisher: Published<[TransactionModel]>.Publisher { $excludedTransactions }
    
    func toggleInclusion(for transaction: TransactionModel) {
        if excludedTransactions.contains(transaction) {
            excludedTransactions.removeAll(where: { $0 == transaction})
        } else {
            excludedTransactions.append(transaction)
        }
    }
    
    func update() {
        allTransactions = ModelData.sampleTransactions
    }
}
