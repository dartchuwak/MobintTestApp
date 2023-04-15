//
//  CellViewModel.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 15.04.2023.
//

import Foundation
import SwiftUI


final class CellViewModel: ObservableObject {
    @Published var item: Item
    
    var cardBackgroundColor: Color {
        Color(UIColor(hex: item.mobileAppDashboard.cardBackgroundColor) ?? .white)
    }
    
    var backgroundColor: Color {
        Color(UIColor(hex: item.mobileAppDashboard.backgroundColor) ?? .lightGray)
    }
    
    var mainColor: Color {
        Color(UIColor(hex: item.mobileAppDashboard.mainColor) ?? .black)
    }
    
    var accentColor: Color {
        Color(UIColor(hex: item.mobileAppDashboard.accentColor) ?? .black)
    }
    
    var textColor: Color {
        Color(UIColor(hex: item.mobileAppDashboard.textColor) ?? .black)
    }
    
    var  highlightTextColor: Color {
       Color(UIColor(hex: item.mobileAppDashboard.highlightTextColor) ?? .white)
    }
    
      
    
    
    init(item: Item) {
        self.item = item
    }
}
