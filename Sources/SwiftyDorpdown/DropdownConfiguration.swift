//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/27/20.
//

import UIKit

public struct DropdownConfiguration {

    public var titleFont                : UIFont = UIFont.systemFont(ofSize: 16,weight: .bold)
    public var titleColor               : UIColor = .black
    public var valueFont                : UIFont = UIFont.systemFont(ofSize: 16,weight: .regular)
    public var valueColor               : UIColor = .black
    public var cornerRadius             : CGFloat = 8
    public var borderWidth              : CGFloat = 2
    public var borderColor              : UIColor = .black
    public var icon                     : String = "drop_down_arrow"
    public var isRTL                    : Bool = false
    
    public var listItemsFont            : UIFont = UIFont.systemFont(ofSize: 16,weight: .regular)
    public var listItemColor            : UIColor = .black
    public var loadingIndicatorStyle    : UIActivityIndicatorView.Style = .gray
    
    public init() {}
}
