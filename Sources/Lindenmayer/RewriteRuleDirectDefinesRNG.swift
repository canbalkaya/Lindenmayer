//
//  RewriteRuleDirectDefinesRNG.swift
//
//
//  Created by Joseph Heck on 1/1/22.
//

import Foundation
import Squirrel3

/// A rule represents a potential re-writing match to elements within the L-systems state and the closure that provides the elements to be used for the new state elements.
public struct RewriteRuleDirectDefinesRNG<DC, PType, PRNG>: Rule where DC: Module, PRNG: SeededRandomNumberGenerator {
    public var parametricEval: ((DC, PType) -> Bool)?

    /// The set of parameters provided by the L-system for rule evaluation and production.
    var parameters: ParametersWrapper<PType>

    /// A psuedo-random number generator to use for stochastic rule productions.
    var prng: RNGWrapper<PRNG>

    /// The signature of the produce closure that provides a module and expects a sequence of modules.
    public typealias singleMatchProducesList = (DC, PType, RNGWrapper<PRNG>) -> [Module]

    /// The closure that provides the L-system state for the current, previous, and next nodes in the state sequence and expects an array of state elements with which to replace the current state.
    public let produceClosure: singleMatchProducesList

    /// The L-system uses the types of these modules to determine is this rule should be applied and re-write the current state.
    public let matchingType: DC.Type

    /// Creates a new rule to match the state element you provide along with a closures that results in a list of state elements.
    /// - Parameters:
    ///   - direct: The type of the L-system state element that the rule evaluates.
    ///   - prng: An optional psuedo-random number generator to use for stochastic rule productions.
    ///   - singleModuleProduce: A closure that produces an array of L-system state elements to use in place of the current element.
    public init(directType direct: DC.Type,
                parameters: ParametersWrapper<PType>,
                prng: RNGWrapper<PRNG>,
                where _: ((DC, PType) -> Bool)?,
                produces singleModuleProduce: @escaping singleMatchProducesList)
    {
        matchingType = direct
        self.parameters = parameters
        self.prng = prng
        produceClosure = singleModuleProduce
    }

    /// Determines if a rule should be evaluated while processing the individual atoms of an L-system state sequence.
    /// - Parameters:
    ///   - leftCtx: The type of atom 'to the left' of the atom being evaluated, if avaialble.
    ///   - directCtx: The type of the current atom to evaluate.
    ///   - rightCtx: The type of atom 'to the right' of the atom being evaluated, if available.
    /// - Returns: A Boolean value that indicates if the rule should be applied to the current atom within the L-systems state sequence.
    public func evaluate(_ matchSet: ModuleSet) -> Bool {
        // short circuit if the direct context doesn't match the matchset's setting
        guard matchingType == matchSet.directInstanceType else {
            return false
        }

        if let additionalEval = parametricEval {
            guard let directInstance = matchSet.directInstance as? DC else {
                return false
            }

            return additionalEval(directInstance, parameters.unwrap())
        }

        return true
    }

    /// Invokes the rule's produce closure with the modules provided.
    /// - Parameter matchSet: The module instances to pass to the produce closure.
    /// - Returns: A sequence of modules that the produce closure returns.
    public func produce(_ matchSet: ModuleSet) -> [Module] {
        guard let directInstance = matchSet.directInstance as? DC else {
            return []
        }
        return produceClosure(directInstance, parameters.unwrap(), prng)
    }
}

extension RewriteRuleDirectDefinesRNG: CustomStringConvertible {
    /// A description of the rule that details what it matches
    public var description: String {
        return "Rule(direct)(\(String(describing: matchingType)) w/ parameters: \(String(describing: parameters)) and rng"
    }
}
