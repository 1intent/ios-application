//
//  TimeIntervalSinceIntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 02/01/2022.
//

import Foundation
import IntentsUseCases

final class TimeIntervalSinceIntentHandler: NSObject, TimeIntervalSinceIntentHandling {

    private let useCase: TimeIntervalSinceUseCaseProtocol

    init(useCase: TimeIntervalSinceUseCaseProtocol = TimeIntervalSinceUseCase()) {
        self.useCase = useCase
    }

    func handle(intent: TimeIntervalSinceIntent) async -> TimeIntervalSinceIntentResponse {
        guard
            let inputDate = intent.inputDate?.date,
            let option = TimeIntervalSinceOption(from: intent.sinceOption, relativeDate: intent.relativeDate?.date)
        else {
            return .init(code: .failure, userActivity: nil)
        }

        let timeInterval = self.useCase.invoke(with: inputDate, option: option)
        let response: TimeIntervalSinceIntentResponse = .init(code: .success, userActivity: nil)
        response.timeInterval = NSNumber(value: timeInterval)
        return response
    }
}

private extension TimeIntervalSinceOption {

    init?(from intentOption: IntentTimeIntervalSinceOption, relativeDate: Date?) {
        switch intentOption {
        case .year1970:
            self = .year1970
        case .referenceDate:
            self = .referenceDate
        case .now:
            self = .now
        case .date:
            guard let relativeDate = relativeDate
            else {
                return nil
            }
            self = .date(relativeDate)
        case .unknown:
            return nil
        }
    }
}
