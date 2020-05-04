//
//  UIDList.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//


import Foundation

// MARK: - UIDList
struct UIDList: Decodable {
    let success: Int
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let uid: String
    let date: Int
    let path: String
    let ratio: String
    let list: [UIDItem]
}

// MARK: - List
struct UIDItem: Decodable {
    let uid: String
    let type: TypeEnum
    let path, thumb: String
    let category: [String]
    let description: String?


}

enum Category: String, Decodable {
    case damages = "damages"
    case exterior = "exterior"
    case features = "features"
    case interior = "interior"
}

enum TypeEnum: String, Decodable {
    case img = "img"
}


