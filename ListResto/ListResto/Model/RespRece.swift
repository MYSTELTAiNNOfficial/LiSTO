//
//  ResponseReceive.swift
//  ListResto
//
//  Created by Syamsuddin Putra Riefli on 30/05/22.
//

import Foundation

struct RespRece : Hashable, Codable {
    var err: Bool
    var message: String
    
    static let `default` = RespRece(err: false, message: "")
}
