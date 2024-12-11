//
//  MultiPartModel.swift
//  NetworkManager
//
//  Created by Binshad Karekkatt Basheer  on 11/12/2024.
//

import Foundation

public struct MultiPartModel {
    let key: String
    let type: MultiPartDataType
    let data: Data
}

public enum MultiPartDataType {
    case text
    case file
}
