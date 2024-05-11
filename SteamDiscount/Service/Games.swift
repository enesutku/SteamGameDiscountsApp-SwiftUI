import Foundation

struct Game: Codable, Identifiable {
    
    let id = UUID()
    // These variable names must be the same as the JSON Data
    var title: String
    var normalPrice: String
    var salePrice: String
    var steamRatingPercent: String
    var thumb: String
    
}

class Api: ObservableObject {
    @Published var games = [Game]()
    
    func loadData(url: String, completion:@escaping ([Game]) -> ()) {
        guard let url = URL(string: url) else {
            print("The URL is invalid!")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            let games = try! JSONDecoder().decode([Game].self, from: data!)
            print(games)
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
}
