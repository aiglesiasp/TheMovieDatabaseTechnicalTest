//
//  Double+Extensions.swift
//  TheMovieDatabaseTechnicalTest
//
//  Created by Aitor Iglesias Pubill on 24/5/23.
//

import Foundation

extension Double {
    var roundedToOneDecimal: String {
        return String(format: "%.1f", self)
    }
}
