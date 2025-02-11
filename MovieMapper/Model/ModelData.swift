//
//  ModelData.swift
//  MovieMapper
//
//  Created by Andre Regino Paniagua on 14/05/24.
//

import Foundation
import SwiftUI


//var movies : [Movie]? = load("movies.json")

func load<T: Decodable>(_ filename: String) async -> T? {
    let data: Data
//   await fetch()
   print("loading movies.json")
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

   let decoder = JSONDecoder()
   do {
        data = try Data(contentsOf: file)
       
       let newData = try decoder.decode(T.self, from: data)
//      print(newData)
      return newData
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
   return nil
}

func getCinemas() async ->Cinemas? {
   //This line is for testing only
//   return await load("template_cinemas.json")
    // Set the location manager
    let locationDataManager = LocationDataManager()

    // Divide the parts of the URL
    let baseUrl = "https://api-gate2.movieglu.com/"
    let endpoint = "cinemasNearby/"
//    let testEndpoint = "filmsNowShowing/"

    // Create the format necessary for the date parameter
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    let currentDate = formatter.string(from: Date())

    // Prepare query parameters
    guard var components = URLComponents(string: baseUrl + endpoint) else {
        print("Error: Invalid URL components")
        return nil
    }

    components.queryItems = [
        URLQueryItem(name: "n", value: "6")
    ]

    // Put together the URL
    guard let url = components.url else {
        print("Error: Invalid URL components")
        return nil
    }

    // Prepare the request
    var request = URLRequest(url: url)
   
   // Get API key form config
   do {
      let key: String = try Configuration.value(for: "API_KEY")
      // Insert Headers
      request.httpMethod = "GET"
      request.addValue("STUD_349", forHTTPHeaderField: "client")
      request.addValue(key, forHTTPHeaderField: "x-api-key")
      request.addValue("Basic U1RVRF8zNDk6c1dVNlRLYTB2Z0dM=", forHTTPHeaderField: "authorization")
      request.addValue("US", forHTTPHeaderField: "territory")
      request.addValue("v200", forHTTPHeaderField: "api-version")
      request.addValue(currentDate, forHTTPHeaderField: "device-datetime")
      
      // Check if user gave permission and set geolocation
      if let location = locationDataManager.locationManager.location {
         let latitude = location.coordinate.latitude
         let longitude = location.coordinate.longitude
         request.addValue("\(latitude);\(longitude)", forHTTPHeaderField: "geolocation")
      } else {
         request.addValue("0.0;0.0", forHTTPHeaderField: "geolocation")
      }
   } catch{
      print(error.localizedDescription )
   }

//   request.addValue("-22.0;14.0", forHTTPHeaderField: "geolocation")


    // Perform request
    do {
        let (data, _) = try await URLSession.shared.data(for: request)

       print("Cinemas Raw bites:\(Array(data))")
        // Print the raw JSON response as a string
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON response: \(jsonString)")
        } else {
            print("Unable to convert data to string")
        }

        let decodedResponse = try JSONDecoder().decode(Cinemas.self, from: data)
        return decodedResponse

    } catch {
        print("Couldn't parse: \(error)")
    }
    return nil
}

func fetch(_ cinema_id: Int) async -> MoviesResponse? {
   
   //This line is for testing only
//   return await load("templeteInfo.json")
   
   
    // Set the location manager
    let locationDataManager = LocationDataManager()
    
    // Divide the parts of the URL
    let baseUrl = "https://api-gate2.movieglu.com/"
    let endpoint = "cinemaShowTimes/"
//    let testEndpoint = "filmsNowShowing/"
    
    // Create the format necessary for the date parameter
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let currentDate = formatter.string(from: Date())
    
    // Prepare query parameters
    guard var components = URLComponents(string: baseUrl + endpoint) else {
        print("Error: Invalid URL components")
        return nil
    }
    
    components.queryItems = [
        URLQueryItem(name: "cinema_id", value: String(cinema_id)),
        URLQueryItem(name: "date", value: currentDate),
        URLQueryItem(name: "sort", value: "popularity")
    ]
    
    // Put together the URL
    guard let url = components.url else {
        print("Error: Invalid URL components")
        return nil
    }
    
    // Prepare the request
    var request = URLRequest(url: url)
    
    // Insert Headers
    request.httpMethod = "GET"
    request.addValue("STUD_349", forHTTPHeaderField: "client")
    request.addValue("frBod4PO0O3gE1EMRnu526D0bck9mHoEfvFaQ1G1", forHTTPHeaderField: "x-api-key")
    request.addValue("Basic U1RVRF8zNDk6c1dVNlRLYTB2Z0dM=", forHTTPHeaderField: "authorization")
    request.addValue("US", forHTTPHeaderField: "territory")
    request.addValue("v200", forHTTPHeaderField: "api-version")
    request.addValue(currentDate, forHTTPHeaderField: "device-datetime")
    
    // Check if user gave permission and set geolocation
    if let location = locationDataManager.locationManager.location {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        request.addValue("\(latitude);\(longitude)", forHTTPHeaderField: "geolocation")
    } else {
        request.addValue("0.0;0.0", forHTTPHeaderField: "geolocation")
    }
    
//   request.addValue("-22.0;14.0", forHTTPHeaderField: "geolocation")
   
   
    // Perform request
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
       print("All Movies Raw bites:\(Array(data))")

        // Print the raw JSON response as a string
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Raw JSON response: \(jsonString)")
//        } else {
//            print("Unable to convert data to string")
//        }
        
        let decodedResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
        return decodedResponse
        
    } catch {
        print("Couldn't parse: \(error)")
    }
    return nil
}

func getURL(film_id: Int, time : String) async -> URL?{
   // Set the location manager
   let locationDataManager = LocationDataManager()
   
   // Divide the parts of the URL
   let baseUrl = "https://api-gate2.movieglu.com/"
   let endpoint = "purchaseConfirmation/"
   
   // Create the format necessary for the date parameter
   let formatter = DateFormatter()
   formatter.dateFormat = "yyyy-MM-dd"
   
   let currentDate = formatter.string(from: Date())
   
   // Prepare query parameters
   guard var components = URLComponents(string: baseUrl + endpoint) else {
       print("Error: Invalid URL components")
       return nil
   }
   
   components.queryItems = [
       URLQueryItem(name: "cinema_id", value: "10841"),
       URLQueryItem(name: "date", value: currentDate),
       URLQueryItem(name: "film_id", value: String(film_id)),
       URLQueryItem(name: "time", value: time)
   ]
   
   // Put together the URL
   guard let url = components.url else {
       print("Error: Invalid URL components")
       return nil
   }
   
   // Prepare the request
   var request = URLRequest(url: url)
   
   // Insert Headers
   request.httpMethod = "GET"
   request.addValue("STUD_349", forHTTPHeaderField: "client")
   request.addValue("frBod4PO0O3gE1EMRnu526D0bck9mHoEfvFaQ1G1", forHTTPHeaderField: "x-api-key")
   request.addValue("Basic U1RVRF8zNDk6c1dVNlRLYTB2Z0dM=", forHTTPHeaderField: "authorization")
   request.addValue("US", forHTTPHeaderField: "territory")
   request.addValue("v200", forHTTPHeaderField: "api-version")
   request.addValue(currentDate, forHTTPHeaderField: "device-datetime")
   
   // Check if user gave permission and set geolocation
   if let location = locationDataManager.locationManager.location {
       let latitude = location.coordinate.latitude
       let longitude = location.coordinate.longitude
       request.addValue("\(latitude);\(longitude)", forHTTPHeaderField: "geolocation")
   } else {
       request.addValue("0.0;0.0", forHTTPHeaderField: "geolocation")
   }
   
   // Perform request
   do {
       let (data, _) = try await URLSession.shared.data(for: request)
       
      print("Website Raw bites:\(Array(data))")

        // Print the raw JSON response as a string
//        if let jsonString = String(data: data, encoding: .utf8) {
//            print("Raw JSON response: \(jsonString)")
//        } else {
//            print("Unable to convert data to string")
//        }
       
      let decodedResponse = try JSONDecoder().decode(getURLResponse.self,from: data)
      return URL(string: decodedResponse.url)
       
   } catch {
       print("Couldn't parse: \(error)")
   }
   return nil
   
}



