//
//  Fall Guy.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 07/05/24.
//

import SwiftUI

struct Fall_Guy: View {
    var body: some View {
       Image("Fall Guy")
         .resizable()
         .frame(width:180, height: 270)
         .aspectRatio(contentMode: .fit)
         .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
         .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.white, lineWidth: 6))
         .shadow(radius: 10)
         .padding()    }
}

#Preview {
    Fall_Guy()
}
