//
//  TopicsOfInterest.swift
//  ALUM
//
//  Created by Neelam Gurnani on 3/11/23.
//

import Foundation

class TopicsOfInterest {
    static var topicsOfInterest: [String] =
        [
            "College Applications",
            "AP Classes",
            "Summer Courses"
        ]

    static var topicsOfInterestTags: [TagState] =
        [
            TagState(tagString: "College Applications", isChecked: false),
            TagState(tagString: "AP Classes", isChecked: false),
            TagState(tagString: "Summer Courses", isChecked: false)
        ]
}
