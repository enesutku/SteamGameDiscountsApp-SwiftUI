// Created by Enes UTKU

import SwiftUI

struct ContentView: View {
    
    @State var games = [Game]()
    
    var body: some View {
        
        NavigationView {
            List(games) { game in
                NavigationLink {
                    VStack {
                        Text("\(game.title)")
                    Text("Steam Rating Percent: %\(game.steamRatingPercent)")
                    }
                } label: {
                    HStack(spacing: 30) {
                        AsyncImage(url: URL(string: game.thumb)!) {
                            image in
                            image
                                .image?.resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 50)
                        }
                        VStack(alignment: .leading, content: {
                            Text("\(game.title)")
                                .fontWeight(.semibold)
                            Text("Normal: $\(game.normalPrice)")
                                .strikethrough()
                            Text("Discounted: $\(game.salePrice)")
                                .foregroundStyle(.red)
                        })
                    }
                }

            }
            .onAppear() {
                Api().loadData(url: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15") {
                    games in self.games = games
                }
            }.navigationTitle("Steam Games")
        }
    }
}

#Preview {
    ContentView()
}
