//
//  ScrollMovies.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 25/5/23.
//

import SwiftUI

struct ScrollMovies: View {
    var movies: [Movie] = []
    var title = ""
    @Binding var isError: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
            ScrollView(.horizontal) {
                if isError {
                    VStack {
                        Text("We can't load the movies")
                    }
                } else {
                    HStack {
                        ForEach(movies) { movie in
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")) { image in
                                NavigationLink {
                                    DetailView(movie: movie)
                                } label: {
                                    image
                                        .resizable()
                                        .frame(width: 200, height: 250)
                                        .cornerRadius(8)
                                }
                            } placeholder: {
                                ProgressView()
                            }
                            
                        }
                    }
                }
            } // End Of ScrollView
        } // End of VStack
    }
}

struct ScrollMovies_Previews: PreviewProvider {
    static var previews: some View {
        ScrollMovies(movies: [], title: "Title", isError: .constant(false))
    }
}
