//
//  FloatingSumView.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 22/05/2022.
//

import SwiftUI

struct FloatingSumView: View {
    
    var category: TransactionModel.Category?
    var total: Double = 0.0
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            Text(category?.rawValue ?? "all")
                .font(.headline)
                .foregroundColor(category?.color ?? .black)
                .padding(.horizontal)
                .padding(.top)
            
            HStack() {
                Text("Total spent:")
                    .secondary()
                
                Spacer()
                
                Text("$\(total.formatted())")
                    .bold()
                    .secondary()
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .overlay(RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color.accentColor, lineWidth: 2.0))
        .padding(8)
    }
}

#if DEBUG
struct FloatingSumView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingSumView(total: 123.45)
    }
}
#endif
