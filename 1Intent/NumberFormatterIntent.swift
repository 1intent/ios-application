//
//  NumberFormatterIntent.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 31/05/2024.
//

import AppIntents
import Foundation

struct NumberFormatterIntent: AppIntent {
    static var title: LocalizedStringResource = "Format Number"

    @Parameter(title: "Number*", description: "The number to format")
    var number: Double

    @Parameter(title: "Style", description: "The formatting style (default: decimal)", default: NumberFormatterStyleType.decimal)
    var style: NumberFormatterStyleType

    @Parameter(title: "Locale", description: "The locale for formatting (default: current locale)")
    var locale: String?

    @Parameter(title: "Minimum Fraction Digits*", description: "The minimum number of fraction digits (default: 0)", default: 0)
    var minimumFractionDigits: Int

    @Parameter(title: "Maximum Fraction Digits*", description: "The maximum number of fraction digits (default: 2)", default: 2)
    var maximumFractionDigits: Int

    @Parameter(title: "Grouping Separator*", description: "Use grouping separator (default: true)", default: true)
    var usesGroupingSeparator: Bool

    @Parameter(title: "Rounding Mode", description: "The rounding mode (default: half even)", default: NumberFormatterRoundingModeType.halfEven)
    var roundingMode: NumberFormatterRoundingModeType

    @Parameter(title: "Negative Prefix", default: "")
    var negativePrefix: String

    @Parameter(title: "Positive Prefix", default: "")
    var positivePrefix: String

    func perform() async throws -> some ReturnsValue<String> {
        let formatter = NumberFormatter()
        if let locale = self.locale {
            formatter.locale = Locale(identifier: locale)
        }
        formatter.minimumFractionDigits = self.minimumFractionDigits
        formatter.maximumFractionDigits = self.maximumFractionDigits
        formatter.usesGroupingSeparator = self.usesGroupingSeparator
        formatter.roundingMode = self.roundingMode.nativeValue
        formatter.numberStyle = self.style.nativeValue
        formatter.negativePrefix = self.negativePrefix
        formatter.positivePrefix = self.positivePrefix
        
        guard let formattedNumber = formatter.string(from: NSNumber(value: number)) else {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to format the number"])
        }

        return .result(value: formattedNumber)
    }

}

enum NumberFormatterStyleType: String, AppEnum {
    case decimal = "Decimal"
    case currency = "Currency"
    case percent = "Percent"
    case scientific = "Scientific"
    case spellOut = "Spell Out"
    case ordinal = "Ordinal"
    case currencyISOCode = "Currency ISO Code"
    case currencyPlural = "Currency Plural"
    case currencyAccounting = "Currency Accounting"

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Number Formatter Style"
    }

    static var caseDisplayRepresentations: [NumberFormatterStyleType: DisplayRepresentation] {
        [
            .decimal: "Decimal",
            .currency: "Currency",
            .percent: "Percent",
            .scientific: "Scientific",
            .spellOut: "Spell Out",
            .ordinal: "Ordinal",
            .currencyISOCode: "Currency ISO Code",
            .currencyPlural: "Currency Plural",
            .currencyAccounting: "Currency Accounting"
        ]
    }

    var nativeValue: NumberFormatter.Style {
        switch self {
        case .decimal:
            return .decimal
        case .currency:
            return .currency
        case .percent:
            return .percent
        case .scientific:
            return .scientific
        case .spellOut:
            return .spellOut
        case .ordinal:
            return .ordinal
        case .currencyISOCode:
            return .currencyISOCode
        case .currencyPlural:
            return .currencyPlural
        case .currencyAccounting:
            return .currencyAccounting
        }
    }
}

enum NumberFormatterRoundingModeType: String, AppEnum {
    case ceiling = "Ceiling"
    case floor = "Floor"
    case down = "Down"
    case up = "Up"
    case halfEven = "Half Even"
    case halfDown = "Half Down"
    case halfUp = "Half Up"


    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Rounding Mode"
    }

    static var caseDisplayRepresentations: [NumberFormatterRoundingModeType: DisplayRepresentation] {
        [
            .ceiling: "Ceiling",
            .floor: "Floor",
            .down: "Down",
            .up: "Up",
            .halfEven: "Half Even",
            .halfDown: "Half Down",
            .halfUp: "Half Up"
        ]
    }

    var nativeValue: NumberFormatter.RoundingMode {
        switch self {
        case .ceiling:
            return .ceiling
        case .floor:
            return .floor
        case .down:
            return .down
        case .up:
            return .up
        case .halfEven:
            return .halfEven
        case .halfDown:
            return .halfDown
        case .halfUp:
            return .halfUp
        }

    }
}
