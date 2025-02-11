//
//  Close.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 25/06/24.
//

import SwiftUI

struct Close: View {
   var body: some View {
      Text("X")
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
    Close()
}
