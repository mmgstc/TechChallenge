//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
import Combine
@testable import TechChallenge

class TechChallengeTests: XCTestCase {

    func testTransactionFilter() throws {
        
        // Given
        let model = TransactionListViewModel()
        let filterSubject = PassthroughSubject<TransactionModel.Category?, Never>()
        var filter: AnyPublisher<TransactionModel.Category?,Never> {
            filterSubject.eraseToAnyPublisher()
        }
        model.bind(filter)
        
        for category in TransactionModel.Category.allCases {
            // When
            filterSubject.send(category)

            // Then
            model.transactions.forEach { transaction in
                XCTAssertTrue(transaction.category == category)
            }
        }
    }
    
    func testAllCategoriesTransactionFilter() throws {
        
        // Given
        let model = TransactionListViewModel()
        let filterSubject = PassthroughSubject<TransactionModel.Category?, Never>()
        var filter: AnyPublisher<TransactionModel.Category?,Never> {
            filterSubject.eraseToAnyPublisher()
        }
        model.bind(filter)
        
        // When
        filterSubject.send(nil)

        // Then
        XCTAssertEqual(model.transactions, ModelData.sampleTransactions)
    }
}
