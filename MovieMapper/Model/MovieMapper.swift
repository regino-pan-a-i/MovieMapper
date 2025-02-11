//
//  movie_mapper.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 14/05/24.
//
//

import Foundation
import SwiftUI
import URLImage

struct MoviesResponse: Decodable {
    let films: [Movie]
}

public struct Movie: Hashable, Decodable {
    var film_id: Int
    var imdb_id: Int
    var imdb_title_id: String
    var film_name: String
    var images: Images
    var showings: Showing
    var age_rating: [Age_Rating]
    var image: some View {
        URLImage(images.poster.medium.film_image) { image in
            image
                .resizable()
        }
    }
}

struct Age_Rating: Hashable, Decodable{
   var rating: String
   var age_rating_image: URL
   var age_advisory: String
}

struct Images: Hashable, Decodable {
    var poster: Poster
    var still: Still?
}

struct Poster: Hashable, Decodable {
   enum CodingKeys: String, CodingKey {
           case one = "1"
       }
   var one: PosterDetail
    
    var medium: PosterMedium {
       return one.medium
    }
}

struct Still: Hashable, Decodable {
   enum CodingKeys: String, CodingKey {
           case one = "1"
       }
   var one: StillDetail
    
    var medium: StillMedium {
       return one.medium
    }
}

struct PosterDetail: Hashable, Decodable {
    var image_orientation: String
    var region: String
    var medium: PosterMedium
}

struct PosterMedium: Hashable, Decodable {
    var film_image: URL
    var width: Int
    var height: Int
}

struct StillDetail: Hashable, Decodable {
    var image_orientation: String
    var medium: StillMedium
}

struct StillMedium: Hashable, Decodable {
    var film_image: URL
    var width: Int
    var height: Int
}

struct Showing: Hashable, Decodable {

   var Standard : Times
}

struct Times : Hashable, Decodable{
    var times: [ShowTime]
    var as_string: String {
        times.reduce("") { accum, showtime in
            if accum == "" {
                return showtime.start_time
            }
            return accum + " " + showtime.start_time
        }
    }
}

struct ShowTime: Hashable, Decodable {
    var start_time: String
    var end_time: String
}



struct getURLResponse: Hashable, Decodable {
    let film_id: Int
    let film_name: String
    let date: String
    let time: String
    let cinema_id: Int
    let cinema_name: String
    let url: String
}


struct Cinemas: Hashable, Decodable {
   let cinemas: [Cinema]
}

struct Cinema: Hashable, Decodable {
   var cinema_id: Int
   var cinema_name: String
   var address: String
   var city: String
   var logo_url: URL   
}





