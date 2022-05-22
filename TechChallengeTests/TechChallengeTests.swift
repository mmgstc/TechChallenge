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
    
    var model: TransactionListViewModel!
    var filterSubject = PassthroughSubject<TransactionModel.Category?, Never>()
    var filter: AnyPublisher<TransactionModel.Category?,Never> {
        filterSubject.eraseToAnyPublisher()
    }
    
    override func setUp() async throws {
        model = TransactionListViewModel()
        model.bind(filter)
    }
    
    override func tearDown() async throws {
        model = nil
    }

    func testFilteredTransactions() throws {
        
        // Given
        
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
        
        // Given the model
        
        // When
        filterSubject.send(nil)

        // Then
        XCTAssertEqual(model.transactions, ModelData.sampleTransactions)
    }
    
    func testTotalForAllTransactions() throws {
        
        // Given
        model = TransactionListViewModel(allTransactions: ModelData.sampleTransactions)
        model.bind(filter)
        
        // When
        filterSubject.send(nil)

        // Then
        XCTAssertEqual(model.total.formatted(), "472.08")
    }
    
    func testTotalForCategories() throws {
        
        // Given
        let totals: [TransactionModel.Category: String] = [
            .food: "74.28",
            .health: "21.53",
            .entertainment: "82.99",
            .shopping: "78.00",
            .travel: "215.28"
        ]
        
        model = TransactionListViewModel(allTransactions: ModelData.sampleTransactions)
        model.bind(filter)
        
        // When
        for category in TransactionModel.Category.allCases {
            // When
            filterSubject.send(category)

            // Then
            XCTAssertEqual(model.total.formatted(), totals[category])
        }
    }
}
