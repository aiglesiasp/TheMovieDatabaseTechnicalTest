//
//  HomeView.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 25/5/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    Spacer()
                    ScrollMovies(movies: viewModel.popularMovies?.results ?? [], title: "Popular Movies", isError: $viewModel.isErrorPopular)
                    ScrollMovies(movies: viewModel.topRatedMovies?.results ?? [], title: "Top Rated Movies", isError: $viewModel.isErrorTopRates)
                    Spacer()
                }
                .searchable(text: $viewModel.query) {
                    ForEach(viewModel.searchedMovies?.results ?? []) { sugestion in
                        NavigationLink {
                            DetailView(movie: sugestion)
                        } label: {
                            HStack(spacing: 16) {
                                AsyncImageView(posterPath: sugestion.posterPath ?? "", movie: sugestion, type: .custom)
                                Text(sugestion.originalTitle ?? "")
                            }
                        }
                    }
                }
                .onChange(of: viewModel.query, perform: { _ in
                    Task {
                        await viewModel.searchMoviesByName()
                    }
                })
                .padding()
                .onAppear {
                    Task {
                        if viewModel.popularMovies?.results?.isEmpty ?? true {
                            await viewModel.getMovies()
                        }
                        
                        if viewModel.topRatedMovies?.results?.isEmpty ?? true {
                            await viewModel.getTopRatedMovies()
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
