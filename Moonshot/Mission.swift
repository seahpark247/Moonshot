//
//  Mission.swift
//  Moonshot
//
//  Created by Seah Park on 5/27/25.
//

import Foundation


// Nested struct
struct Mission: Codable, Identifiable, Hashable {
    struct CrewRole: Codable, Hashable, Equatable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
