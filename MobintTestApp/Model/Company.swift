// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let empty = try? JSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

// MARK: - Element
struct Item: Codable, Identifiable, Hashable {
    let company: Company
    let customerMarkParameters: CustomerMarkParameters
    let mobileAppDashboard: MobileAppDashboard
    var id: Int?
}

// MARK: - Company
struct Company: Codable, Hashable  {
    let companyId: String
   
}

// MARK: - CustomerMarkParameters
struct CustomerMarkParameters: Codable, Hashable  {
    let loyaltyLevel: LoyaltyLevel
    let mark: Int
}

// MARK: - LoyaltyLevel
struct LoyaltyLevel: Codable, Hashable  {
    let number: Int
    let name: String
    let requiredSum, markToCash, cashToMark: Int
}

// MARK: - MobileAppDashboard
struct MobileAppDashboard: Codable, Hashable  {
    let companyName: String
    let logo: String
    let backgroundColor, mainColor, cardBackgroundColor, textColor: String
    let highlightTextColor, accentColor: String
}

typealias Empty = [Item]
