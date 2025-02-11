//
//  CinemasSelection.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 17/07/24.
//

import SwiftUI

struct Slidable2: View {
   var cinemas: Cinemas
   var onCinemaSelected: (Int) -> Void
   
   var body: some View {
      VStack{
         Spacer()
         CinemasSelection(cinemas: cinemas, onCinemaSelected: onCinemaSelected)
         Spacer()
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
       .background(.ultraThinMaterial)

   }

}

struct CinemasSelection: View {
    let cinemas: Cinemas
   let onCinemaSelected: (Int) -> Void  // Callback

    
    let columns = [
      GridItem(.flexible()),
      GridItem(.flexible())
    ]

    var body: some View {
      VStack {
         Text("Cinemas Near You")
            .font(.title)
            .foregroundColor(.black)
         LazyVGrid(columns: columns, spacing: 20) {
            ForEach(cinemas.cinemas, id: \.cinema_id) { cinema  in
               Button( action:{
                  onCinemaSelected(cinema.cinema_id)
               }){
                  CinemaLogo(cinema: cinema)
               }
               
              }
         }
         .padding()
      }
      .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      .background(.ultraThinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 25.0))
      .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.gray, lineWidth: 6))
      .shadow(radius: 10)
    }

          
}
//
//struct CinemaSelection_Previews: PreviewProvider {
//   static var previews: some View {
//      let sampleCinemas = Cinemas(cinemas:[
//      Cinema(
//        cinema_id: 8795,
//        cinema_name: "ODEON Leicester Square",
//        address: "24-26 Leicester Square",
//        city: "London",
//        logo_url: URL(string: "https://d2z9fe5yu2p0av.cloudfront.net/chainlogos/uk/UK-614-sq.jpg")!
//      ),
//      Cinema(
//        cinema_id: 8796,
//        cinema_name: "Vue Cinemas - West End",
//        address: "3 Cranbourn Street",
//        city: "London",
//        logo_url: URL(string: "https://d2z9fe5yu2p0av.cloudfront.net/chainlogos/uk/UK-712-sq.jpg")!
//      ),
//      Cinema(
//        cinema_id: 8797,
//        cinema_name: "Cineworld Leicester Square",
//        address: "5-6 Leicester Square",
//        city: "London",
//        logo_url: URL(string: "https://d2z9fe5yu2p0av.cloudfront.net/chainlogos/uk/UK-868-sq.jpg")!
//      ),
//      Cinema(
//        cinema_id: 8799,
//        cinema_name: "Prince Charles Cinema",
//        address: "7 Leicester Place",
//        city: "London",
//        logo_url: URL(string: "https://d2z9fe5yu2p0av.cloudfront.net/chainlogos/uk/UK-0-sq.jpg")!
//      )
//   ])
//       
//        return Group {
//            Slidable2(cinemas: sampleCinemas)
//        }
//    }
//}
