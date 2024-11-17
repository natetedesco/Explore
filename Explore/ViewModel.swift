//
//  ViewModel.swift
//  Explore
//  Created by Developer on 5/29/24.
//

import SwiftUI

@Observable class ViewModel {
    var showMainSheet = true // always
    
    // Explore
    var showResults = false
    var showLocation = false
    var showImage = false
    
    // Profile
    var showProfile = false
    var showLeaveReview = false
    
    // Settings
    var showMapSettings = false
    
    var showSearchThisArea = false
    
    var detent = PresentationDetent.fraction(1/7)
    //    { didSet {
    //        lightHaptic()
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { // fixes sheet bug
    //            if self.detent == .fraction(4/10) || self.detent == .fraction(999/1000) {
    //                self.showResults = true
    //            } else {
    //                self.showResults = false
    //            }
    //        }
    //        print("\(detent)")
    //    }}
}

import MapKit
@Observable class Profile {
    var toggle = 0 { didSet { lightHaptic() }}

    
}
