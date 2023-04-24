//
//  ServiceConstants.swift
//  ALUM
//
//  Created by Yash Ravipati on 4/24/23.
//

import Foundation

let baseURL = "http://localhost:3000"
struct APIRoutes {
    static let mentorPOST = baseURL + "/mentor"
    static let menteePOST = baseURL + "/mentee"
    static let mentorGET = baseURL + "/mentor/"
    static let menteeGET = baseURL + "/mentee/"
}
