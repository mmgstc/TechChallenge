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
    
    @Published var transactions: [TransactionModel] = ModelData.sampleTransactions
    @Published var category: TransactionModel.Category? = nil
    
    func bind(_ filter: AnyPublisher<TransactionModel.Category?,Never>) {
        filter
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
            .sink { category in
                
                self.category = category
                
                guard let category = category else {
                    self.transactions = ModelData.sampleTransactions
                    return
                }
                self.transactions = ModelData.sampleTransactions.filter({ $0.category == category })
            }
            .store(in: &cancelBag)
    }
}
