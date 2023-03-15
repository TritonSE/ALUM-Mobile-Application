//
//  CareerInterests.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/11/23.
//

import Foundation

class CareerInterests {
    static var menteeCareerInterests: [String] =
        [
            "Statistics",
            "Computer Science",
            "Product Management"
        ]
    
    static var menteeCareerInterestsTags: [TagState] =
        [
            TagState(tagString: "Statistics", isChecked: false),
            TagState(tagString: "Computer Science", isChecked: false),
            TagState(tagString: "Product Management", isChecked: false)
        ]
}
