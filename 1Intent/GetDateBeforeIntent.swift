//
//  GetDateBeforeIntent.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 03/06/2024.
//

import AppIntents
import Foundation


enum DateComponentAppEnum: String, AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Date component"
    static var caseDisplayRepresentations: [DateComponentAppEnum : DisplayRepresentation] = [.hour: "hour", .day: "day", .month: "month", .year: "year"]

    case hour
    case day
    case month
    case year

    var calendarComponent: Calendar.Component {
        switch self {
        case .day:
            return .day
        case .hour:
            return .hour
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}


enum DateComponentOperation: String, AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Operation"
    static var caseDisplayRepresentations: [DateComponentOperation : DisplayRepresentation] = [.add: "adding", .substract: "substracting"]

    case add
    case substract
}
struct GetDateBeforeIntent: AppIntent {
    static var title: LocalizedStringResource = "Get date before another date"

    @Parameter(title: "Date")
    var inputDate: Date

    @Parameter(title: "Date component", default: .day)
    var dateComponent: DateComponentAppEnum

    @Parameter(title: "Operation", default: .substract)
    var operation: DateComponentOperation

    @Parameter(title: "Value", default: 1)
    var value: Int

    static var parameterSummary: some ParameterSummary {
        Summary("Get date by \(\.$operation) \(\.$value) \(\.$dateComponent) to \(\.$inputDate)")
    }

    func perform() async throws -> some ReturnsValue<Date> {
        let calendar = Calendar.current
        let value = switch self.operation {
        case .add:
            self.value
        case .substract:
            -self.value
        }
        guard let newDate = calendar.date(byAdding: self.dateComponent.calendarComponent, value: value, to: self.inputDate) else {
            return .result(value: self.inputDate)
        }
        return .result(value: newDate)
    }
}
