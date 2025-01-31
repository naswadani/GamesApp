//
//  GamesDetailView.swift
//  Dicoding Games
//
//  Created by naswakhansa on 30/12/24.
//

import SwiftUI
import CommonPodSpec

public struct GameDetailView: View {
    @StateObject var viewModel: GameDetailViewModel
    
    public init(viewModel: GameDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea(.all)
            switch viewModel.state {
            case .idle:
                ScrollView(.vertical, showsIndicators: false) {
                    ImageLoaderView(paddingButton: 125, imageURL: viewModel.gameDetail?.backgroundImage, sizeFont: 20)
                        .frame(width: 350, height: 250)
                        .clipped()
                        .overlay(
                            Group {
                                if let metacritic = viewModel.gameDetail?.metacritic {
                                    Text("\(metacritic)")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.green)
                                        )
                                }
                            }
                                .offset(x: -30, y: -20),
                            alignment: .bottomTrailing
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .frame(width: 350, height: 250)
                        )
                        .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 20) {
                        if let name = viewModel.gameDetail?.name {
                            Text(name)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        if let rateGame = viewModel.gameDetail?.formattedRating {
                            Label(rateGame, systemImage: "star.fill" )
                                .font(.system(size: 15, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                                .offset(y: -10)
                        }
                        
                        if let platfromGame = viewModel.platfromGame {
                            Text(platfromGame)
                                .font(.system(size: 15, weight: .light, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        if let realesedGame = viewModel.gameDetail?.released {
                            Text(realesedGame)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                        }
                        
                        VStack(alignment: .leading) {
                            if let description = viewModel.gameDetail?.description {
                                Text("About")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                    .padding(.top, 20)
                                Text(description)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .padding(.bottom, 10)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let genre = viewModel.genreGame {
                                Text("Genre")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                Text(genre)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .padding(.bottom, 10)
                            }
                            
                            if let developerGame = viewModel.developerGame {
                                Text("Developer")
                                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                                Text(developerGame)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .padding(.bottom, 10)
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                    .padding(.bottom)
                }
            case .loading:
                ProgressView()
                    .zIndex(1)
            case .failed(let error):
                StateView(message: error) {
                    viewModel.fetchGameDetail()
                }
            }
        }
        .onAppear {
            viewModel.fetchGameDetail()
        }
    }
}
