//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/29/20.
//

import UIKit

class DropdownCell: UITableViewCell {
        
    static var reuseIdentifier = "DropDownCell"
    private var container = UIView()
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = configuration.listItemsFont
        label.textAlignment = configuration.isRTL ? .right : .left
        return label
    }()
    
    var item : DropdownItem? {
        didSet {
            titleLabel.text = item?.title
        }
    }
    var configuration: DropdownConfig {
        didSet {
            titleLabel.font = configuration.listItemsFont
            titleLabel.textAlignment = configuration.isRTL ? .right : .left
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        configuration = DropdownConfig()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.snp.updateConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        container.addSubview(titleLabel)
        titleLabel.snp.updateConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
