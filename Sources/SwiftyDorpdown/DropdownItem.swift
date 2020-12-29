//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/27/20.
//

import Foundation

@objc public protocol DropdownItem {
    var title : String? { get }
    var subtitle: String? { get }
    var icon: String? { get }
}
