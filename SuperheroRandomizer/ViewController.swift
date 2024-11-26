//
//  ViewController.swift
//  SuperheroRandomizer
//
//  Created by Ляззат Аманбаева on 26.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!    
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var combatLabel: UILabel!
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var superheroImageView: UIImageView!
    
    
    var superheroes: [Superhero] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchSuperheroes()
        }

        func fetchSuperheroes() {
            NetworkManager.shared.fetchSuperheroes { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let superheroes):
                        self?.superheroes = superheroes
                        print("Fetched \(superheroes.count) superheroes!")
                    case .failure(let error):
                        print("Error fetching superheroes: \(error)")
                    }
                }
            }
        }
    func getRandomSuperhero() -> Superhero? {
        return superheroes.randomElement()
    }


    @IBAction func RandomizeButtonTapped(_ sender: Any) { showRandomSuperhero()
    }
    func showRandomSuperhero() {
        guard let randomSuperhero = getRandomSuperhero() else {
            print("No superheroes available.")
            return
        }

        // Update the UI with the superhero's details
        updateUI(with: randomSuperhero)
    }
    func updateUI(with superhero: Superhero) {
        // Update UI elements like labels and imageView
        nameLabel.text = superhero.name
        fullNameLabel.text = superhero.fullName ?? "Unknown"
        intelligenceLabel.text = "Intelligence: \(superhero.powerstats.intelligence)"
        strengthLabel.text = "Strength: \(superhero.powerstats.strength)"
        speedLabel.text = "Speed: \(superhero.powerstats.speed)"
        
        combatLabel.text = "Combat: \(superhero.powerstats.combat)"
        durabilityLabel.text = "Durability: \(superhero.powerstats.durability)"
        raceLabel.text = "Race: \(superhero.appearance.race ?? "Unknown")"
        heightLabel.text = "Height: \(superhero.appearance.height.last ?? "Unknown")"
        weightLabel.text = "Weight: \(superhero.appearance.weight.last ?? "Unknown")"
        
        // Load the image from the URL
        if let imageURL = URL(string: superhero.images.lg) {
            loadImage(from: imageURL)
        }
    }

    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image: \(String(describing: error))")
                return
            }

            DispatchQueue.main.async {
                self.superheroImageView.image = UIImage(data: data)
            }
        }.resume()
    }


}

