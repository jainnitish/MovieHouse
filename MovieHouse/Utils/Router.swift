//
//  Router.swift
//  MovieHouse
//
//  Created by Nitish Jain on 06/10/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Hashable {
        case movieDetail(MovieId: Int)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}
