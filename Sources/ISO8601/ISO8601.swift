//
//  ISO8601.swift
//
/// Расщирения классов ISO8601DateFormatter, Formatter, DateDecodingStrategy, DateEncodingStrategy
///  для реализации возможности корректного захвата времени из JSON,
///  а так же корректного создания JSON документов из структур
//
//  Created by Дмитрий Папков on 20.03.2021.
//

import Foundation

public extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options) {
        self.init()
        self.formatOptions = formatOptions
    }
}

public extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
}

public extension JSONDecoder.DateDecodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        
        if let date = Formatter.iso8601.date(from: string) {
            return date
        }
        
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) {
            return date
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: " + string)
    }
}

public extension JSONEncoder.DateEncodingStrategy {
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}
