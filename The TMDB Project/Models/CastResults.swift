//
//  CastResults.swift
//  The TMDB Project
//
//  Created by Beqa Tabunidze on 13.08.22.
//

import Foundation

// MARK: - CastResults

struct CastResults: Decodable {
    let id: Int
    let cast, crew: [Cast?]
}
