//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    let transactions: [TransactionModel] = ModelData.sampleTransactions
    
    @ObservedObject var viewModel: InsightsViewModel
    
    init(viewModel: InsightsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            RingView(viewModel: viewModel.ringViewModel)
                .scaledToFit()
            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    
                    Text("$\((viewModel.categoriesTotalMap[category] ?? 0.0).formatted())")
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InsightsViewModel(transactionProvider: AppModel.shared)
        AppModel.shared.update()
        return InsightsView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
#endif
