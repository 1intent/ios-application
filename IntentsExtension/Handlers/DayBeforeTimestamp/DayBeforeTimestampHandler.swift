//
//  DayBeforeTimestampHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 30/05/2024.
//

import Foundation
import IntentsUseCases
import Intents

final class DayBeforeTimestampHandler: NSObject, DayBeforeTimestampIntentHandling {

    private let useCase: DayBeforeTimestampUseCase

    init(useCase: DayBeforeTimestampUseCase = DayBeforeTimestampUseCaseImpl()) {
        self.useCase = useCase
    }

    func handle(intent: DayBeforeTimestampIntent) async -> DayBeforeTimestampIntentResponse {
        let dayReferenceDTO = intent.dayReference
        guard let dayReference = DayReference(from: dayReferenceDTO, date: intent.date?.date) 
        else {
            return .init(code: .failure, userActivity: nil)
        }

        let startOfDay: Bool
        switch intent.dayType {
        case .startOfDay:
            startOfDay = true
        case .endOfDay:
            startOfDay = false
        default:
            return .init(code: .failure, userActivity: nil)
        }
        let response: DayBeforeTimestampIntentResponse = .init(code: .success, userActivity: nil)
        response.timestamp = NSNumber(value: self.useCase.execute(reference: dayReference, startOfDay: startOfDay))
        return response
    }

    func resolveDate(for intent: DayBeforeTimestampIntent) async -> INDateComponentsResolutionResult {
        return INDateComponentsResolutionResult.confirmationRequired(with: intent.date!)
    }

    func resolveDayType(for intent: DayBeforeTimestampIntent) async -> IntentDayBeforeTimestampdayRangeTypeResolutionResult {
        IntentDayBeforeTimestampdayRangeTypeResolutionResult.confirmationRequired(with: intent.dayType)
    }
}

private extension DayReference {

    init?(from intentOption: IntentDayBeforeTimestampReference, date: Date?) {
        switch intentOption {
        case .today:
            self = .today
        case .date:
            guard let date = date
            else {
                return nil
            }
            self = .specific(date)
        case .unknown:
            return nil
        }
    }
}
