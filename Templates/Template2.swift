//
//  Template2.swift
//  Linter
//
//  Created by pixyzehn on 2017/05/28.
//
//

import Foundation

protocol Pokemon {
    associatedtype PokemonType
    func attack(move:PokemonType) // Violate the `colon` intentionally
}

struct Pikachu: Pokemon {
    typealias PokemonType = Thunder
    func attack(move: Thunder) { /*⚡️*/ }
}

class charmander: Pokemon { // Violate the `type_name` intentionally
    func attack(move: Fire) { /*🔥*/ }
}

class Raichu: Pokemon {
    typealias PokemonType = Thunder
    func attack(move: Thunder) { /*⚡️*/ }
}

class AnyPokemon <PokemonType>: Pokemon {
    private let _attack: ((PokemonType) -> ()) // Violate the `void_return`intentionally

    required init<U: Pokemon>(_ pokemon: U) where U.PokemonType == PokemonType {
        _attack = pokemon.attack
    }

    func attack(type: PokemonType) {
        return _attack(type)
    }
}
