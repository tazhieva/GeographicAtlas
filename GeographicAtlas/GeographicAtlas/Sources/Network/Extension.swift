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
        
        if population < 1_000_000 {
            formatter.groupingSeparator = " "
        } else {
            formatter.maximumFractionDigits = 3
            formatter.groupingSeparator = "."
            return formatter.string(from: NSNumber(value: population / 1_000_000))! + " mln"
        }
        
        return (formatter.string(from: NSNumber(value: population)) ?? "") + "k"
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
