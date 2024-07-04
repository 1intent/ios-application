//
//  VariationCalculationIntent.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 31/05/2024.
//

import Foundation
import AppIntents

struct VariationCalculationIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Variation"

    @Parameter(title: "Old value")
    var oldValue: Double?

    
    @Parameter(title: "New value")
    var newValue: Double?

    static var parameterSummary: some ParameterSummary {
        Summary("Get variation between \(\.$oldValue) & \(\.$newValue)")
    }

    func perform() async throws -> some ReturnsValue<Double?> {
        guard let oldValue = self.oldValue,
              let newValue = self.newValue
        else {
            return .result(value: nil)
        }
        guard oldValue != 0
        else {
            return .result(value: nil)
        }

        let variation = ((newValue - oldValue) / oldValue)
        return .result(value: variation)
    }
}
