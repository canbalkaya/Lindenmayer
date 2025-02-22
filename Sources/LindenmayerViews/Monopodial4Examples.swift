//
//  Monopodial4Examples.swift
//
//
//  Created by Joseph Heck on 1/17/22.
//

import Lindenmayer
import SceneKit
import SwiftUI

/// A view that presents the 4 SceneKit scenes that include example trees with a monopodial structure built in to Lindenmayer.
///
/// The set of trees match the examples of figure 2.6 in [The Algorithmic Beauty of Plants](http://algorithmicbotany.org/papers/abop/abop.pdf) on page 56.
public struct Monopodial4Examples: View {
    let system1: LSystem
    let system2: LSystem
    let system3: LSystem
    let system4: LSystem
    let renderer = SceneKitRenderer()
    public var body: some View {
        VStack {
            HStack {
                Lsystem3DView(system: system1)
                Lsystem3DView(system: system2)
            }
            HStack {
                Lsystem3DView(system: system3)
                Lsystem3DView(system: system4)
            }
        }
    }

    public init() {
        system1 = Detailed3DExamples.monopodialTree
            .setParameters(params: Detailed3DExamples.figure2_6A)
            .evolved(iterations: 10)
        system2 = Detailed3DExamples.monopodialTree
            .setParameters(params: Detailed3DExamples.figure2_6B)
            .evolved(iterations: 10)
        system3 = Detailed3DExamples.monopodialTree
            .setParameters(params: Detailed3DExamples.figure2_6C)
            .evolved(iterations: 10)
        system4 = Detailed3DExamples.monopodialTree
            .setParameters(params: Detailed3DExamples.figure2_6D)
            .evolved(iterations: 10)
    }
}

struct Monopodial4Examples_Previews: PreviewProvider {
    static var previews: some View {
        Monopodial4Examples()
    }
}
