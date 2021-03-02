//
//  FLXAlbumCodable.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation

struct FLXResponseCodable: Codable {
    let offset: Int?
    let count: Int?
    let total: Int?
    let results: [FLXAlbumCodable]?
    
    enum CodingKeys: String, CodingKey {
        case offset = "Offset"
        case count = "Count"
        case total = "Total"
        case results = "Results"
    }
    
    init(from decoder: Decoder) throws {
        let keyedValues = try decoder.container(keyedBy: CodingKeys.self)
        
        self.offset = try keyedValues.decodeIfPresent(Int.self, forKey: .offset)
        self.count = try keyedValues.decodeIfPresent(Int.self, forKey: .count)
        self.total = try keyedValues.decodeIfPresent(Int.self, forKey: .total)
        
        self.results = try keyedValues.decodeIfPresent([FLXAlbumCodable].self, forKey: .results)
    }
}

struct FLXAlbumCodable: Codable {
    let primaryRelease: FLXPrimaryReleaseCodable?

    enum CodingKeys: String, CodingKey {
        case primaryRelease = "PrimaryRelease"
    }

    init(from decoder: Decoder) throws {
        let keyedValues = try decoder.container(keyedBy: CodingKeys.self)

        self.primaryRelease = try keyedValues.decodeIfPresent(FLXPrimaryReleaseCodable.self, forKey: .primaryRelease)
    }
}

struct FLXPrimaryReleaseCodable: Codable {
    let albumId: Int32?
    let name: String?
    let image: String?
    let label: FLXLabel?
    
    enum CodingKeys: String, CodingKey {
        case albumId = "AlbumId"
        case name = "Name"
        case image = "Image"
        case label = "Label"
    }
    
    init(from decoder: Decoder) throws {
        let keyedValues = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try keyedValues.decodeIfPresent(String.self, forKey: .name)
        self.albumId = try keyedValues.decodeIfPresent(Int32.self, forKey: .albumId)
        self.image = try keyedValues.decodeIfPresent(String.self, forKey: .image)
        self.label = try keyedValues.decodeIfPresent(FLXLabel.self, forKey: .label)
    }
}

struct FLXLabel: Codable {
    let labelId: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case labelId = "LabelId"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let keyedValues = try decoder.container(keyedBy: CodingKeys.self)

        self.labelId = try keyedValues.decodeIfPresent(String.self, forKey: .labelId)
        self.name = try keyedValues.decodeIfPresent(String.self, forKey: .name)
    }
}

