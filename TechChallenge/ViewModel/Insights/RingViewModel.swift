//
//  RingViewModel.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 23/05/2022.
//

import Foundation
import Combine

class RingViewModel: ObservableObject {
        
    @Published var ratioMap: [TransactionModel.Category: Double] = [:]

    func updateModel(for categoriesTotalMap: [TransactionModel.Category: Double]) {
        
        let total = categoriesTotalMap.reduce(0.0, { partialResult, element in
            partialResult + element.value
        })
        
        ratioMap = categoriesTotalMap.mapValues { categoryTotal in
            guard total > 0 else {
                return 0
            }
            return categoryTotal/total
        }
    }
}
