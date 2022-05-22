//
//  CategoriesFilterBar.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 22/05/22.
//

import SwiftUI
import Combine

struct CategoriesFilterBar: View {

    typealias Action = (_ category: TransactionModel.Category?) -> Void
    private let action: Action
    
    init(with action: @escaping Action) {
        self.action = action
    }
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                // All Categories
                CategoryButton(category: nil, action: buttonTap(for:))
                
                // TransactionModel categories
                ForEach(TransactionModel.Category.allCases) { category in
                    CategoryButton(category: category, action: buttonTap(for:))
                }

            }
            .padding(12)
        }
        .background(Color.accentColor.opacity(0.8))
    }
    
    private func buttonTap(for category: TransactionModel.Category?) {
        action(category)
    }
}

#if DEBUG
struct CategoriesFilterBar_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesFilterBar(with: { _ in })
    }
}
#endif

private struct CategoryButton: View {
    
    typealias Action = (TransactionModel.Category?) -> Void
    
    let category: TransactionModel.Category?
    let action: Action
    
    init(category: TransactionModel.Category?, action: @escaping Action) {
        self.category = category
        self.action = action
    }

    var body: some View {
        Button(action: tapAction) {
            Text(category?.rawValue ?? "all")
                .padding(6)
        }
        .background(category?.color ?? .black)
        .foregroundColor(.white)
        .font(.system(.title2).weight(.bold))
        .clipShape(Capsule())
    }
    
    private func tapAction() {
        action(category)
    }
}

#if DEBUG
struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(category: nil, action: {_ in })
    }
}
#endif

