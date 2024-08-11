//
//  LoadingView.swift
//  IMoviesSwiftUI
//
//  Created by AMIT on 11/08/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
