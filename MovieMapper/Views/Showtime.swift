//
//  Showtime.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 24/06/24.
//

import SwiftUI

struct Showtime<T: StringProtocol>: View {
    var time: T

    var body: some View {
        Text(time)
            .font(.headline)
            .foregroundColor(.black)
            .frame(width: 60, height: 30)
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 3.0))
            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.green, lineWidth: 2))
            .shadow(radius: 10)
            .padding()
    }
}

#Preview {
    Showtime(time: "12:00")
}
