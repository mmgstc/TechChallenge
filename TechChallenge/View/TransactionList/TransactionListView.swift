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
        
    private let cateforyFilterBar = CategoriesFilterBar()
    
    var body: some View {
        
        VStack {
            
            cateforyFilterBar
            
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
        viewModel.bind(cateforyFilterBar.filter)
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: TransactionListViewModel())
    }
}
#endif
