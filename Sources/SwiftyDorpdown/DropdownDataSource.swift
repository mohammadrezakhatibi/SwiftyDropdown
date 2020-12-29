//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/29/20.
//

import Foundation

public protocol DropdownDataSource:class {
    func items(_ dropDown: SwiftyDorpdown) ->  [DropdownItem]?
}
