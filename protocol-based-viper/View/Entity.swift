//
//  User.swift
//  protocol-based-viper
//
//  Created by Osinnowo Emmanuel on 01/03/2023.
//

import UIKit

struct User: Decodable {
    var name: String
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
