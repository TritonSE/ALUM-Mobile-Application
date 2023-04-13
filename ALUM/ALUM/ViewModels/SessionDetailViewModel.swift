//
//  SessionDetailViewModel.swift
//  ALUM
//
//  Created by Neelam Gurnani on 4/13/23.
//

import Foundation

final class SessionDetailViewModel: ObservableObject {
    @Published var session: Session = Session()
    @Published var formIsComplete: Bool = false
    @Published var sessionCompleted: Bool = false
}
