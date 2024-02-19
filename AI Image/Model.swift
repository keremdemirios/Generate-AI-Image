//
//  Model.swift
//  AI Image
//
//  Created by Kerem Demir on 19.02.2024.
//

import Foundation

struct Response: Decodable {
    let data: [ImageURL]
}

struct ImageURL: Decodable {
    let url: String
}
