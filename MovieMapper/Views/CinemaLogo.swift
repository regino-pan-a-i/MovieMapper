//
//  CinemaLogo.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 17/07/24.
//

import SwiftUI
import URLImage

struct CinemaLogo: View {
   let cinema: Cinema

    var body: some View {
        VStack {
            URLImage(cinema.logo_url) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) // Adjust as needed
            }
           Text(cinema.cinema_name)
              .font(.title3)
              .foregroundColor(.black)
              .multilineTextAlignment(.center)
        }
    }
}

struct CinemaLogo_Previews: PreviewProvider {
    static var previews: some View {
        let cinema = Cinema(
            cinema_id: 8795,
            cinema_name: "ODEON Leicester Square",
            address: "24-26 Leicester Square",
            city: "London",
            logo_url: URL(string: "https://d2z9fe5yu2p0av.cloudfront.net/chainlogos/uk/UK-614-sq.jpg")!
        )
        return Group {
            CinemaLogo(cinema: cinema)
        }
    }
}
