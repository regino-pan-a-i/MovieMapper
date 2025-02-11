//
//  ContentView.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    @State private var showCinemas = true
    @State private var index = 0
    @State private var allMovies: [Movie]? = nil
    @State private var more = false
    @State private var cinema_id = 0
    @State private var cinemas: Cinemas = Cinemas(cinemas: [])
    @State private var isCinemaIdSet = false

    let locationDataManager = LocationDataManager()

    var body: some View {
       ZStack {
          Color.white
             .ignoresSafeArea()
             VStack(alignment: .center) {
                Spacer()
                HStack(alignment: .center) {
                   if let movies = allMovies, movies.indices.contains(index) {
                      VStack {
                         Button {
                            withAnimation {
                               showDetails.toggle()
                            }
                            // Ensure index is within bounds
                            if movies.indices.contains(index) {
                               index = index
                            }
                         } label: {
                            PosterButton(movie: movies[index])
                         }
                         Text(movies[index].film_name)
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                         Spacer()
                      }
                   }
                   
                   if let movies = allMovies, movies.indices.contains(index + 1) {
                      VStack {
                         Button {
                            withAnimation {
                               showDetails.toggle()
                            }
                            // Ensure index + 1 is within bounds
                            if movies.indices.contains(index + 1) {
                               index += 1
                            }
                         } label: {
                            PosterButton(movie: movies[index + 1])
                         }
                         Text(movies[index + 1].film_name)
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                         Spacer()
                      }
                   }
                }
                if let movies = allMovies, movies.indices.contains(index + 2) {
                   HStack(alignment: .center) {
                      VStack {
                         Button {
                            withAnimation {
                               showDetails.toggle()
                            }
                            // Ensure index + 2 is within bounds
                            if movies.indices.contains(index + 2) {
                               index += 2
                            }
                         } label: {
                            PosterButton(movie: movies[index + 2])
                         }
                         Text(movies[index + 2].film_name)
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                         Spacer()
                      }
                      if movies.indices.contains(index + 3) {
                         VStack {
                            Button {
                               withAnimation {
                                  showDetails.toggle()
                               }
                               // Ensure index + 3 is within bounds
                               if movies.indices.contains(index + 3) {
                                  index += 3
                               }
                            } label: {
                               PosterButton(movie: movies[index + 3])
                            }
                            Text(movies[index + 3].film_name)
                               .font(.title3)
                               .foregroundColor(.black)
                               .multilineTextAlignment(.center)
                            Spacer()
                         }
                      }
                   }
                }
                Button(action: {
                   more.toggle()
                   if more {
                      if let movies = allMovies, movies.indices.contains(4) {
                         index = 4
                      }
                   } else {
                      index = 0
                   }
                }) {
                   More()
                }
             }
          
          if showDetails {
             if let movies = allMovies, movies.indices.contains(index) {
                Slidable(movie: movies[index])
                   .transition(.move(edge: .bottom))
                Close()
                   .offset(y: 300)
                   .padding(30)
                   .transition(.move(edge: .bottom))
                   .onTapGesture {
                      showDetails = false
                   }
             }
          }
          if showCinemas{
             
             Slidable2(cinemas: cinemas){ selectedCinemaId in
                cinema_id = selectedCinemaId  // Set the selected cinema_id
               showCinemas = false  // Hide the Slidable2 view
             }
                .transition(.move(edge: .bottom))
          }
       }
        .onAppear {
           Task{
              if let response = await getCinemas(){
                 cinemas = response
              }
           }
//            Task {
//               if let response = await fetch(cinema_id) {
//                    allMovies = response.films
//                }
//            }
        }
        .onChange(of: cinema_id) { newValue in
             if newValue != 0 {
                 Task {
                     if let response = await fetch(newValue) {
                         allMovies = response.films
                     }
                 }
             }
         }
    }
}

#Preview {
    
    ContentView()
}
