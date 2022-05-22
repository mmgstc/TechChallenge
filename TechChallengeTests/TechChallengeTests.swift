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
    
    var transactionProvider: TransactionProvider!
    var model: TransactionListViewModel!
    var filterSubject = PassthroughSubject<TransactionModel.Category?, Never>()
    var filter: AnyPublisher<TransactionModel.Category?,Never> {
        filterSubject.eraseToAnyPublisher()
    }
    
    
    override func setUp() async throws {
        transactionProvider = MockTransactionProvider()
        model = TransactionListViewModel(transactionProvider: transactionProvider)
        model.bind(filter)
    }
    
    override func tearDown() async throws {
        model = nil
        transactionProvider = nil
    }

    func testFilteredTransactions() throws {
        
        // Given
        transactionProvider.update()
        
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
        transactionProvider.update()

        // When
        filterSubject.send(nil)

        // Then
        XCTAssertEqual(model.transactions, ModelData.sampleTransactions)
    }
    
    func testTotalForAllTransactions() throws {
        
        // Given
        model.bind(filter)
        transactionProvider.update()
        
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
        
        transactionProvider.update()
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

private class MockTransactionProvider: TransactionProvider {
    
    @Published var allTransactions: [TransactionModel] = []
    var allTransactionsPublished: Published<[TransactionModel]> { _allTransactions }
    var allTransactionsPublisher: Published<[TransactionModel]>.Publisher { $allTransactions }
    
    @Published var excludedTransactions: [TransactionModel] = []
    var excludedTransactionsPublished: Published<[TransactionModel]> { _excludedTransactions }
    var excludedTransactionsPublisher: Published<[TransactionModel]>.Publisher { $excludedTransactions }
    
    func toggleInclusion(for transaction: TransactionModel) {
        
    }
    
    func update() {
        allTransactions = ModelData.sampleTransactions
    }
}
