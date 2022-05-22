//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(viewModel: TransactionListViewModel(transactionProvider: AppModel.shared))
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(viewModel: InsightsViewModel(transactionProvider: AppModel.shared))
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
            .onAppear(perform: {
                AppModel.shared.update()
            })
        }
    }
}
