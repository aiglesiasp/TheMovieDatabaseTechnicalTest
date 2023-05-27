//
//  AsyncImageView.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import SwiftUI

enum ImageType {
    case custom
    case detail
}

struct AsyncImageView: View {
    let posterPath: String
    let movie: Movie
    let type: ImageType
    let width: CGFloat = 50
    let height: CGFloat = 50

    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)")) { image in
            NavigationLink {
                DetailView(movie: movie)
            } label: {
                switch type {
                case .custom:
                    image
                        .resizable()
                        .frame(width: width, height: height)
                        .cornerRadius(8)
                case .detail:
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                }
                
            }
        } placeholder: {
            ProgressView()
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(posterPath: "", movie: Movie(adult: true, id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 5.0, posterPath: "", releaseDate: "", title: "", voteAverage: 9.0), type: .custom)
    }
}
