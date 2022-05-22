//
//  TransactionModelCollectionHelpers.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 22/05/2022.
//

import Foundation

extension Array where Element == TransactionModel {
    
    func total() -> Double {
        return self.reduce(0.0, { partial, transaction in
            partial + transaction.amount
        })
    }
    
    func filter(by category: TransactionModel.Category) -> Self {
        return self.filter({ $0.category == category })
    }
    
    func filter(excluding transactions: [TransactionModel]) -> Self {
        return Array(Set(self).subtracting(Set(transactions)))
    }
}
