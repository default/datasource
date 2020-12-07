//
//  NSObject.swift
//  DataSource
//
//  Created by Nikita Mikheev on 03.12.2020.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
