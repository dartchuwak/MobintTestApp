//
//  Alert.swift
//  MobintTestApp
//
//  Created by Evgenii Mikhailov on 15.04.2023.
//

import Foundation

enum AlertType: Identifiable {
    case error(NetworkError)
    case selectedItem(MyAlert)

    var id: UUID { UUID() }
}
