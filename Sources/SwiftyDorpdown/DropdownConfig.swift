//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/27/20.
//

import UIKit

public struct DropdownConfig {

    public var titleFont                : UIFont = UIFont.systemFont(ofSize: 16,weight: .bold)
    public var valueFont                : UIFont = UIFont.systemFont(ofSize: 16,weight: .regular)
    public var cornerRadius             : CGFloat = 8
    public var borderWidth              : CGFloat = 2
    public var borderColor              : UIColor = .black
    public var icon                     : String = "drop_down_arrow"
    public var isRTL                    : Bool = false
    
    public var listItemsFont            : UIFont = UIFont.systemFont(ofSize: 16,weight: .regular)
    public var loadingIndicatorStyle    : UIActivityIndicatorView.Style = .gray
    
    public init() {}
}
