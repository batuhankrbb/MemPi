//
//  MPErrors.swift
//  MemPi
//
//  Created by Batuhan Karababa on 1.11.2020.
//

import Foundation

enum MPError: Error {
    case notEnoughCoin
}

extension  MPError:LocalizedError{
    public var errorDescription: String?{
        switch self {
        case .notEnoughCoin:
            return NSLocalizedString("You do not have enough coin. Do you want to earn 30 coin and get rich? 🤑", comment: "Description of error while decreasing coin")
        }
    }
}
