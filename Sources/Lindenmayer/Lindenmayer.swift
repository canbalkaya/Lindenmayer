//
//  Lindenmayer.swift
//
//
//  Created by Joseph Heck on 1/1/22.
//

import Foundation

/// A type that provides convenient initializers for L-systems.
public enum Lindenmayer {
    /// Creates a new Lindenmayer system from an initial state.
    /// - Parameters:
    ///   - axiom: An initial module that represents the initial state of the Lindenmayer system..
    public static func basic(_ axiom: Module) -> LSystemBasic {
        return LSystemBasic([axiom], state: nil, newStateIndicators: nil)
    }

    /// Creates a new Lindenmayer system from an initial state.
    /// - Parameters:
    ///   - axiom: A sequence of modules that represents the initial state of the Lindenmayer system..
    public static func basic(_ axiom: [Module]) -> LSystemBasic {
        return LSystemBasic(axiom, state: nil, newStateIndicators: nil)
    }

    /// Creates a new Lindenmayer system from an initial state and using the random number generator you provide.
    /// - Parameters:
    ///   - axiom: An initial module that represents the initial state of the Lindenmayer system..
    ///   - prng: A psuedo-random number generator to use for randomness in rule productions.
    public static func withRNG<RNGType>(_ axiom: Module, prng: RNGType) -> LSystemRNG<RNGType> {
        return LSystemRNG(axiom: [axiom], state: nil, newStateIndicators: nil, prng: RNGWrapper(prng))
    }

    /// Creates a new Lindenmayer system from an initial state and using the random number generator you provide..
    /// - Parameters:
    ///   - axiom: A sequence of modules that represents the initial state of the Lindenmayer system..
    ///   - prng: A psuedo-random number generator to use for for randomness in rule productions.
    public static func withRNG<RNGType>(_ axiom: [Module], prng: RNGType) -> LSystemRNG<RNGType> {
        return LSystemRNG(axiom: axiom, state: nil, newStateIndicators: nil, prng: RNGWrapper(prng))
    }

    /// Creates a new Lindenmayer system from an initial state, using the random number generator and parameter instance that you provide.
    /// - Parameters:
    ///   - axiom: An initial module that represents the initial state of the Lindenmayer system.
    ///   - prng: A psuedo-random number generator to use for for randomness in rule productions.
    ///   - parameters: An instance of type you provide that the L-system provides to the rules you create for use as parameters.
    public static func withDefines<PType, RNGType>(_ axiom: Module, prng: RNGType, parameters: PType) -> LSystemDefinesRNG<PType, RNGType> {
        return LSystemDefinesRNG(axiom: [axiom], state: nil, newStateIndicators: nil, parameters: ParametersWrapper(parameters), prng: RNGWrapper(prng), rules: [])
    }

    /// Creates a new Lindenmayer system from an initial state, using the random number generator and parameter instance that you provide.
    /// - Parameters:
    ///   - axiom: A sequence of modules that represents the initial state of the Lindenmayer system..
    ///   - prng: A psuedo-random number generator to use for for randomness in rule productions.
    ///   - parameters: An instance of type you provide that the L-system provides to the rules you create for use as parameters.
    public static func withDefines<PType, RNGType>(_ axiom: [Module], prng: RNGType, parameters: PType) -> LSystemDefinesRNG<PType, RNGType> {
        return LSystemDefinesRNG(axiom: axiom, state: nil, newStateIndicators: nil, parameters: ParametersWrapper(parameters), prng: RNGWrapper(prng), rules: [])
    }
}
