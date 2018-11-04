//
//  Utils.swift
//  Social posts

import Foundation


class Utils {
    static let dateForamtter = DateFormatter()
    public static func convertDateToString(date: Date) -> String {
        dateForamtter.dateFormat = "dd MMM YYYY hh:mm a"
        return dateForamtter.string(from:date)
    }
}
