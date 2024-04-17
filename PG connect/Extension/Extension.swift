//
//  Extension.swift
//  PG connect
//
//  Created by PRITAM SARKAR on 02/03/24.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

/// Offset View Extension
extension View{
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace,completion: @escaping (CGFloat)->())->some View{
        self
            .overlay {
                GeometryReader{proxy in
                    let minY = proxy.frame(in: coordinateSpace).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
}
extension Date {
    func formattedDate2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
extension String {
    func formattedDate3() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        if let date = dateFormatter.date(from: self) {
            let formattedDateFormatter = DateFormatter()
            formattedDateFormatter.dateFormat = "dd MMM"
            return formattedDateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
}
extension String {
    // Function to format date from ISO 8601 string
    func formattedDate() -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        if let date = dateFormatter.date(from: self) {
            let formattedDateFormatter = DateFormatter()
            formattedDateFormatter.dateFormat = "dd-MM-yyyy"
            return formattedDateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    func formattedTime() -> String {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            
            if let date = dateFormatter.date(from: self) {
                let timeFormatter = DateFormatter()
                timeFormatter.timeStyle = .short
                timeFormatter.dateStyle = .none
                
                return timeFormatter.string(from: date)
            } else {
                return "Invalid Date"
            }
        }
}


struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var message: String
}

