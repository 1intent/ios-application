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

    @Parameter(title: "First Number", description: "The first number for the calculation")
    var firstNumber: Double?

    @Parameter(title: "Second Number", description: "The second number for the calculation")
    var secondNumber: Double?

    @Parameter(title: "Output Format", description: "The format for the output (default: raw number)", default: OutputFormatType.rawNumber)
    var outputFormat: OutputFormatType

    func perform() async throws -> some ReturnsValue<Double?> {
        guard let firstNumber = self.firstNumber,
              let secondNumber = self.secondNumber
        else {
            return .result(value: nil)
        }
        let variation = ((secondNumber - firstNumber) / firstNumber)
        switch self.outputFormat {
        case .rawNumber:
            return .result(value: variation)
        case .rawPercent:
            return .result(value: variation * 100)
        }
    }
}

enum OutputFormatType: String, AppEnum {
    case rawNumber = "Raw Number"
    case rawPercent = "Raw Percent"

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Output Format"
    }

    static var caseDisplayRepresentations: [OutputFormatType: DisplayRepresentation] {
        [
            .rawNumber: "Raw Number",
            .rawPercent: "Raw Percent",
        ]
    }
}
