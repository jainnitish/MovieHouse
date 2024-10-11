//
//  MovieHouseApp.swift
//  MovieHouse
//
//  Created by Nitish Jain on 03/10/24.
//

import SwiftUI

@main
struct MovieHouseApp: App {
    
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                MovieListView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .movieDetail(let movieId):
                            MovieDetailView(movieId: movieId)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
