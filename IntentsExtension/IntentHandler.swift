//
//  IntentHandler.swift
//  IntentsExtension
//
//  Created by Pierre Abi-aad on 01/01/2022.
//

import Intents
import IntentsUseCases

final class IntentHandler: INExtension {

    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is CURLIntent:
            return CURLIntentHandler()
        case is ChatGPTIntent:
            return ChatGPTIntentHandler()
        case is DayBeforeTimestampIntent:
            return DayBeforeTimestampHandler()
        case is TimeIntervalSinceIntent:
            return TimeIntervalSinceIntentHandler()
        case is URIEncodeIntent:
            return URIEncodeIntentHandler()
        case is URLQueryIntent:
            return URLQueryIntentHandler()
        case is UUIDIntent:
            return UUIDIntentHandler()
        default:
            return self
        }
    }
}
