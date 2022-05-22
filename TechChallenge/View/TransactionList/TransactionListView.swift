//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI
import Combine

struct TransactionListView: View {
    
    @ObservedObject var viewModel: TransactionListViewModel
            
    var body: some View {
        
        VStack {
            CategoriesFilterBar(with: { category in
                viewModel.updateModel(for: category)
            })
            
            List {
                ForEach(viewModel.transactions) { transaction in
                    TransactionView(transaction: transaction) {
                        viewModel.togglePin(for: transaction)
                    }
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            
            FloatingSumView(category: viewModel.category, total: viewModel.total)
        }
    }
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TransactionListViewModel(transactionProvider: AppModel.shared)
        AppModel.shared.update()
        return TransactionListView(viewModel: viewModel)
    }
}
#endif
