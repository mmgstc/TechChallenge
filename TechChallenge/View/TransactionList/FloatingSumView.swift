//
//  FloatingSumView.swift
//  TechChallenge
//
//  Created by Manuele Maggi on 22/05/2022.
//

import SwiftUI

struct FloatingSumView: View {
    
    var body: some View {
        HStack {
            Text("Total spent:")
            VStack {
                Text("")
            }
        }
    }
}

#if DEBUG
struct FloatingSumView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingSumView()
    }
}
#endif
