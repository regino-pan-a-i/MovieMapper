//
//  MovieCard.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 14/05/24.
//

import SwiftUI

struct Slidable: View {
   var movie: Movie
   var body: some View {
      VStack{
         Spacer()
         MovieCard(movie: movie)
         Spacer()
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
       .background(.ultraThinMaterial)

   }

}

struct MovieCard: View {
    @State private var showDetails = false
    var movie: Movie

    @State private var showtimeLinks: [Int: URL] = [:] // Dictionary to store URLs with indices as keys

    let columns = [GridItem(.adaptive(minimum: 60))]

    var body: some View {
        VStack {
            HStack {
                PosterButton(movie: movie)
                    .frame(width: 140, height: 230)
                Spacer()
                VStack {
                    Text(movie.film_name)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Text(movie.age_rating[0].rating)
                        .font(.headline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    Text(movie.age_rating[0].age_advisory)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            Spacer()
            HStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(movie.showings.Standard.times.indices, id: \.self) { index in
                            if let link = showtimeLinks[index] {
                                Link(destination: link) {
                                    Showtime(time: movie.showings.Standard.times[index].start_time)
                                }
                            } else {
                               ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle())
                                 .scaleEffect(1)
//                                Text("Loading...")
//                                    .onAppear {
//                                        fetchURL(for: movie, at: index)
//                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
        .frame(width: 370, height: 460)
        .background {
            Color.white
                .blur(radius: 8, opaque: true)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.gray, lineWidth: 6))
        .shadow(radius: 10)
        .onAppear {
            fetchAllURLs()
        }
    }
   
   func fetchURL(for movie: Movie, at index: Int) {
           Task {
               if let url = await getURL(film_id: movie.film_id, time: movie.showings.Standard.times[index].start_time) {
                   DispatchQueue.main.async {
                       showtimeLinks[index] = url
                   }
               }
           }
       }
    
    func fetchAllURLs() {
        for index in movie.showings.Standard.times.indices {
            Task {
                if let url = await getURL(film_id: movie.film_id, time: movie.showings.Standard.times[index].start_time) {
                    DispatchQueue.main.async {
                        showtimeLinks[index] = url
                    }
                }
            }
        }
    }
}



//#Preview {
//   let movie = Movie(
//      film_id: 567,
//      imdb_id: 567,
//      imdb_title_id: "title", 
//      film_name: "title",
//      rating: "good",
//      imageURL:  URL(string: "https://image.movieglu.com/346189/346189h1.jpg")!,
//      showing: Showing(
//         film_id: 234,
//         film_name: "name",
//         times: [ShowTime(
//            start_time: "12:00",
//            end_time: "2:00")]))
//   MovieCard(movie: movie)
//}


//struct MovieCard_Previews: PreviewProvider {
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
//            MovieCard(movie: movie)
//                .previewLayout(.sizeThatFits)
//                .padding()
//        }
//    }
//}
