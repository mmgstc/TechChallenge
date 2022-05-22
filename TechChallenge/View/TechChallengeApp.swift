//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {
    
    @ObservedObject var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(viewModel: TransactionListViewModel(transactionProvider: appModel))
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(viewModel: InsightsViewModel(transactionProvider: appModel))
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
            .onAppear(perform: {
                appModel.update()
            })
        }
    }
}
