//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/29/20.
//

import Foundation

@objc public protocol DropdownViewDelegate:class {
    @objc optional func dropdownViewDidTap(_ dropDown: SwiftyDorpdown)
    @objc optional func dropdownDidSelectItem(_ dropDown: SwiftyDorpdown, item : DropdownItem?)
}
