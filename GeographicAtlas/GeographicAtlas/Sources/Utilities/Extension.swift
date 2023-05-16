//
//  Extension.swift
//  GeographicAtlas
//
//  Created by Акмарал Тажиева on 15.05.2023.
//

import UIKit

extension UITableViewCell {
    
    func attributedText(withText text: String) -> NSAttributedString {
        let colonRange = (text as NSString).range(of: ":")
        let attributedText = NSMutableAttributedString(string: text)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, colonRange.location + 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSMakeRange(colonRange.location + 2, text.count - colonRange.location - 2))
        attributedText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSMakeRange(colonRange.location, 1))
        
        return attributedText
    }

    func formatPopulation(_ population: Int?) -> String {
        guard let population = population else {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if population >= 1_000_000 {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population / 1_000_000))! + " mln"
        } else if population >= 1_000 {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population))! + "k"
        } else {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population)) ?? ""
        }
    }
    
    func formatArea(_ area: Double?) -> String {
        guard let area = area else {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if area < 1_000_000 {
            formatter.groupingSeparator = " "
            formatter.maximumFractionDigits = 0
            return formatter.string(from: NSNumber(value: area)) ?? ""
        } else {
            let million = 1_000_000.0
            let formattedNumber = formatter.string(from: NSNumber(value: area/million)) ?? ""
            return formattedNumber + " mln"
        }
    }
}

extension UIViewController {
    func formatBulletList(withText text: String) -> NSAttributedString {
        let bulletPoint = "• "
        let attributedText = NSMutableAttributedString()
        
        guard let colonRange = text.range(of: ":") else {
            // If the colon is not found, return the text as is
            attributedText.append(NSAttributedString(string: "\(bulletPoint)\(text)"))
            return attributedText
        }
        
        let bulletPointAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        
        let grayColor = UIColor.gray
        
        attributedText.append(NSAttributedString(string: bulletPoint, attributes: bulletPointAttributes))
        
        let textBeforeColonRange = text.startIndex..<colonRange.upperBound
        
        let textAfterColonRange = colonRange.upperBound..<text.endIndex
        
        attributedText.append(NSAttributedString(string: String(text[textBeforeColonRange]), attributes: [.foregroundColor: grayColor]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.firstLineHeadIndent = bulletPoint.size(withAttributes: bulletPointAttributes).width
        
        attributedText.append(NSAttributedString(string: "\n\(String(text[textAfterColonRange]))", attributes: [.foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]))
        
        return attributedText
    }
    
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    func formatPopulation(_ population: Int?) -> String {
        guard let population = population else {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if population >= 1_000_000 {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population))! + " mln"
        } else if population >= 1_000 {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population))! + "k"
        } else {
            formatter.groupingSeparator = " "
            return formatter.string(from: NSNumber(value: population)) ?? ""
        }
    }
    
    
    func formatCoordinates(_ coordinates: [Double]) -> String {
        let latitude = coordinates[0]
        let longitude = coordinates[1]
        
        let latDegrees = Int(latitude)
        let longDegrees = Int(longitude)
        
        let latMinutes = Int((latitude - Double(latDegrees)) * 60)
        let longMinutes = Int((longitude - Double(longDegrees)) * 60)
        
        let formattedCoordinates = "\(latDegrees)°\(latMinutes)′, \(longDegrees)°\(longMinutes)′"
        
        return formattedCoordinates
    }
}
