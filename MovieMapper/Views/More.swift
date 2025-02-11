//
//  More.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 12/07/24.
//

import SwiftUI

struct More: View {
   var body: some View {
      Text("+")
         .font(.headline)
         .foregroundColor(.black)
         .frame(width:50, height: 50)
         .aspectRatio(contentMode: .fit)
         .clipShape(Circle())
         .overlay(Circle().stroke(Color.gray, lineWidth:3))
         .shadow(radius: 10)
         .padding()
      
   }
}

#Preview {
    More()
}
