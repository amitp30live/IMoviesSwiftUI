//
//  TitleValueRow.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 11/08/24.
//

import SwiftUI

struct TitleValueView<Title: StringProtocol, Value: StringProtocol>: View {
    let title: Title
    let value: Value

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .bold()
            Text(value)
                .font(.subheadline)
                .padding(.trailing,5)
            Spacer()
        }
    }
}
