//
//  ChuckModels.swift
//  iOSV3
//
//  Created by Marcus Malmgren on 2023-11-16.
//

import Foundation


struct ChuckNorrisInfo : Codable {
    var id: String
    var created_at: String
    var value: String
}

struct ChuckNorrisSearchResult : Codable {
    var total: Int
    var result: [ChuckNorrisInfo]
}
