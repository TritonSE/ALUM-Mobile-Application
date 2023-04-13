//
//  SessionDetailViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
}
