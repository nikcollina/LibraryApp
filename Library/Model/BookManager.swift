//
//  BookManager.swift
//  Library
//
//  Created by Nikolas Collina on 10/19/20.
//

import Foundation

struct Book {
    var author : String?
    var country : String
    var image : String
    var language : String
    var link : String
    var pages : Int
    var title : String
    var year : Int
    var reading : Bool
    var currentPage : String
    var notes : [String]
    var noteProgress : [String]
    var noteDate : [String]
}

extension Book : Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        country = try values.decode(String.self, forKey: .country)
        image = try values.decode(String.self, forKey: .image)
        language = try values.decode(String.self, forKey: .language)
        link = try values.decode(String.self, forKey: .link)
        pages = try values.decode(Int.self, forKey: .pages)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(Int.self, forKey: .year)
        reading = try values.decodeIfPresent(Bool.self, forKey: .reading) ?? false
        currentPage = try values.decodeIfPresent(String.self, forKey: .currentPage) ?? "0"
        notes = try values.decodeIfPresent([String].self, forKey: .notes) ?? [""]
        noteProgress = try values.decodeIfPresent([String].self, forKey: .noteProgress) ?? [""]
        noteDate = try values.decodeIfPresent([String].self, forKey: .noteDate) ?? [""]
    }
}

