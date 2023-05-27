//
//  DetailView.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 27/5/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel = DetailViewModel()
    @State var isFavorite = false
    var movie: Movie
    var body: some View {
        VStack {
            ZStack {
                AsyncImageView(posterPath: movie.posterPath ?? "", movie: movie, type: .detail)
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.6)
                    VStack(alignment: .leading, spacing: 8) {
                        // MARK: -Section title with Favorite button
                        Spacer()
                        HStack {
                            Text(movie.originalTitle ?? "")
                                .font(.title2)
                                .foregroundColor(.black)
                            Spacer()
                            
                            Button {
                                isFavorite
                                ? viewModel.deleteFavorite(movie: movie)
                                : viewModel.saveFavorite(movie: movie)
                                isFavorite.toggle()
                            } label: {
                                if (isFavorite) {
                                    Image(systemName: "heart.circle")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 20, height: 20)
                                        .padding(.top, 5)
                                        .padding(.trailing, 20)
                                }else {
                                    Image(systemName: "heart.circle")
                                        .resizable()
                                        .foregroundColor(.black)
                                        .frame(width: 20, height: 20)
                                        .padding(.top, 5)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                        
                        // MARK:  End Section title with Favorite button -
                        
                        Text(movie.overview ?? "")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        HStack {
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                            Text(movie.voteAverage?.roundedToOneDecimal ?? "")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .onAppear {
                        viewModel.loadFavorites()
                        isFavorite = viewModel.checkIfIsFavorite(movie: movie)
                    }
                }
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: Movie(adult: true, id: 1, originalLanguage: "", originalTitle: "", overview: "", popularity: 10.0, posterPath: "", releaseDate: "", title: "", voteAverage: 9.0))
    }
}
