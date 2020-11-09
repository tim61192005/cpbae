//
//  Section.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/20.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var sbeject: [String]!
    var expanded: Bool!

    init(genre: String, sbeject: [String]!, expanded: Bool) {
        self.genre = genre
        self.sbeject = sbeject
        self.expanded = expanded
        
    }
}
