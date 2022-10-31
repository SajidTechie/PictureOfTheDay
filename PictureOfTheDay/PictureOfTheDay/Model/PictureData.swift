//
//  PictureData.swift
//  PictureOfTheDay
//
//  Created by Sajid kantharia on 31/10/22.
//

import Foundation

struct PictureData: Decodable {
    let copyright, date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
    
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.copyright = try container.decode(String.self, forKey: .copyright)
        self.date = try container.decode(String.self, forKey: .date)
        self.explanation = try container.decode(String.self, forKey: .explanation)
        self.hdurl = try container.decode(String.self, forKey: .hdurl)
        self.mediaType = try container.decode(String.self, forKey: .mediaType)
        self.serviceVersion = try container.decode(String.self, forKey: .serviceVersion)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
