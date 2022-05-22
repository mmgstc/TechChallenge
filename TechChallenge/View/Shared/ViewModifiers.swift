//
//  ViewModifiers.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

extension Text {
    func primary() -> some View {
        self
            .bold()
            .font(.body)
            .foregroundColor(.accentColor)
    }
    
    func secondary() -> some View {
        self
            .font(.body)
            .foregroundColor(.accentColor)
    }
    
    func tertiary() -> some View {
        self
            .font(.caption)
            .foregroundColor(.accentColor)
            .opacity(0.8)
    }
    
    func percentage() -> some View {
        self
            .font(.title2)
            .bold()
            .foregroundColor(Color(UIColor.label))
    }
    
    func categoryHeading(_ category: TransactionModel.Category?) -> some View{
        self
            .font(.headline)
            .foregroundColor(category.color)
    }
}

extension Button {
    func categoryButton(_ category: TransactionModel.Category?) -> some View {
        self
            .buttonStyle(CategoryButtonStyle())
            .background(category.color)
            .clipShape(Capsule())
    }
}

extension Image {
    static func pin(_ isPinned: Bool) -> Image {
        return  Image(systemName: isPinned ? "pin.fill" : "pin.slash.fill")
    }
}

private struct CategoryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .foregroundColor(.white)
            .font(.system(.title2).weight(.bold))
            .padding(6)
    }
}
