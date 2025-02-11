//
//  PosterButton.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 28/05/24.
//

import SwiftUI

struct PosterButton: View {
   var movie: Movie?
   var body: some View {
      movie?.image
         .frame(width:140, height: 230)
         .aspectRatio(contentMode: .fit)
         .clipShape(RoundedRectangle(cornerRadius: 25.0))
         .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(.white, lineWidth: 6))
         .shadow(radius: 10)
         .padding()
   }
}
//
//#Preview {
//    PosterButton()
//}


//struct PosterButton_Previews: PreviewProvider {
//    static var previews: some View {
//        let movie = Movie(
//            film_id: 567,
//            imdb_id: 567,
//            imdb_title_id: "title",
//            film_name: "Godzila vs Kong",
////            rating: "good",
//            film_image: URL(string: "https://image.movieglu.com/346189/346189h1.jpg")!,
//            showings: Showing(
//                times: [
//                  ShowTime(
//                  start_time: "12:00",
//                  end_time: "2:00"),
//                  ShowTime(
//                    start_time: "2:00",
//                    end_time: "2:00"),
//                  ShowTime(
//                    start_time: "5:00",
//                    end_time: "2:00")
//                ]
//            )
//        )
//        
//        return Group {
//            PosterButton(movie: movie)
//                .previewLayout(.sizeThatFits)
//                .padding()
//        }
//    }
//}
