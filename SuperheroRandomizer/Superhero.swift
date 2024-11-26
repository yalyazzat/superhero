//
//  Superhero.swift
//  SuperheroRandomizer
//
//  Created by Ляззат Аманбаева on 26.11.2024.
//

import Foundation

struct Superhero: Codable {
    let id: Int
    let name: String
    let fullName: String? // Moved to Biography
    let powerstats: Powerstats
    let images: Images
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
}

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Images: Codable {
    let xs: String
    let sm: String
    let md: String
    let lg: String
}

struct Biography: Codable {
    let alterEgos: String
    let aliases: [String]
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
    let height: [String] // ["5'10", "178 cm"]
    let weight: [String] // ["165 lb", "75 kg"]
    let eyeColor: String?
    let hairColor: String?
}

struct Work: Codable {
    let occupation: String?
    let base: String?
}

struct Connections: Codable {
    let groupAffiliation: String?
    let relatives: String?
}

