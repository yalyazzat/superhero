//
//  NetworkManager.swift
//  SuperheroRandomizer
//
//  Created by Ляззат Аманбаева on 26.11.2024.
//


import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    let superheroURL = URL(string: "https://akabab.github.io/superhero-api/api/all.json")!

    func fetchSuperheroes(completion: @escaping (Result<[Superhero], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: superheroURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }

            do {
                let superheroes = try JSONDecoder().decode([Superhero].self, from: data)
                completion(.success(superheroes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
