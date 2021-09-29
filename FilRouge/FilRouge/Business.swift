//
//  Business.swift
//  FilRouge
//
//  Created by Student08 on 01/09/2021.
//

import Foundation

struct Business :Codable{
    var name : String
    var image_url : String
    var location : Location
    var distance : Double
    var url : String
    var categories : [Categorie]
}
