//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/29/20.
//

import UIKit

class DropdownWithImageCell: UITableViewCell {
        
    static var reuseIdentifier = "DropdownWithImageCell"
    private var titleLabel = UILabel()
    private var iconView = UIImageView()
    private var container = UIView()
    private var stackView : UIStackView!
    
    var item : DropdownItem? {
        didSet {
            titleLabel.text = item?.title
            iconView.image = UIImage(named: item?.icon ?? "")
        }
    }
    var configuration: DropdownConfiguration {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        configuration = DropdownConfiguration()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        iconView.contentMode = .scaleAspectFit
        container.addSubview(iconView)
        container.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        titleLabel.font = configuration.listItemsFont
        titleLabel.textAlignment = configuration.isRTL ? .right : .left
        iconView.snp.updateConstraints { (make) in
            make.width.equalTo(36)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            if configuration.isRTL {
                make.right.equalToSuperview()
            } else {
                make.left.equalToSuperview()
            }
        }

        titleLabel.snp.updateConstraints { (make) in
            if configuration.isRTL {
                make.right.equalTo(iconView.snp.left).offset(-8)
            } else {
                make.left.equalTo(iconView.snp.right).offset(8)
            }
            make.centerY.equalToSuperview()
        }
    }
}
