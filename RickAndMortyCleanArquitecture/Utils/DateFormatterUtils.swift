//
//  DateFormatterUtils.swift
//  RickAndMortyCleanArquitecture
//
//  Created by Edgar Guitian Rey on 19/12/23.
//

import Foundation

class DateFormatterUtils {
    static func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        return dateFormatter.date(from: dateString)
    }

    static func convertDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current

        return dateFormatter.string(from: date)
    }

    static func formatDate(_ dateString: String) -> String {
        let dateCreated = convertStringToDate(dateString)
        guard let dateCreatedClean = dateCreated else {
            return dateString
        }

        let dateCreatedDescription = convertDateToString(dateCreatedClean)
        return dateCreatedDescription
    }
}
