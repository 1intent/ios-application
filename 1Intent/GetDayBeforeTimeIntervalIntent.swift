//
//  GetDayBeforeTimeIntervalIntent.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 03/06/2024.
//

import AppIntents
import Foundation
import IntentsUseCases

enum DayRangePosition: String, AppEnum {
    static var caseDisplayRepresentations: [DayRangePosition : DisplayRepresentation] = [.start: "start of day", .end: "end of day"]

    case start
    case end

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Day range position type"
}

struct GetDayBeforeTimeIntervalIntent: AppIntent {
    static var title: LocalizedStringResource = "Get day timeinterval since 1970"

    @Parameter(title: "Date")
    var date: Date

    @Parameter(title: "range")
    var dayRangePosition: DayRangePosition

    static var parameterSummary: some ParameterSummary {
        Summary("Get day timeinterval since 1970 for \(\.$date) from \(\.$dayRangePosition)")
    }

    func perform() async throws -> some ReturnsValue<TimeInterval> {
        let startOfDay: Bool
        switch self.dayRangePosition {
        case .start:
            startOfDay = true
        case .end:
            startOfDay = false
        }

        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self.date)

        if startOfDay {
            components.hour = 0
            components.minute = 0
            components.second = 0
            components.nanosecond = 0
        } else {
            components.hour = 23
            components.minute = 59
            components.second = 59
            components.nanosecond = 999999999
        }

        guard let modifiedDate = calendar.date(from: components) else {
            return .result(value: -1)
        }
        return .result(value: modifiedDate.timeIntervalSince1970)
    }
}
