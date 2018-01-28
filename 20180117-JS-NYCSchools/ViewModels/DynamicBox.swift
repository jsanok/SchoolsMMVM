//
//  DynamicBox.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/26/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation

class DynamicBox <T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)//update on bind
    }
}






