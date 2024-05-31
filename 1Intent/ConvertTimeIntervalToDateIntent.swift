//
//  ConvertTimeIntervalToDateIntent.swift
//  1Intent
//
//  Created by Pierre Abi-aad on 31/05/2024.
//

import Foundation
import AppIntents

struct ConvertTimeIntervalToDateIntent: AppIntent {
    static var title: LocalizedStringResource = "Convert Time Interval to Date"

    @Parameter(title: "Time Interval", description: "Time interval in seconds")
    var timeInterval: Double

    func perform() async throws -> some ReturnsValue<Date> {
        let date = Date(timeIntervalSince1970: self.timeInterval)
        return .result(value: date)
    }
}
