//
//  DropDownView.swift
//  Top Change
//
//  Created by MohammadReza Khatibi on 6/11/20.
//  Copyright © 2020 Top Change. All rights reserved.
//

import UIKit
import SnapKit
import PanModal

open class SwiftyDorpdown: UIView {
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    public var txtField         : UITextField!
    public weak var delegate    : DropdownViewDelegate?
    public weak var dataSource  : DropdownDataSource?
    private var container       : UIView!
    public var selectedItem     : DropdownItem?
    private var items           : [DropdownItem]?
    private var loading         = UIActivityIndicatorView()
    private let iconView        = UIImageView()
    private var tapped          : Bool = false
    
    private var configuration   : DropdownConfiguration!
    
    public var isEnabled        : Bool? {
        didSet {
            isUserInteractionEnabled = isEnabled ?? true
        }
    }
    
    public init(title: String? = nil,placeholder: String? = nil,configuration: DropdownConfiguration? = nil,iconValue: String? = nil) {
        
        super.init(frame: .zero)
        registerTapGesture()
        
        if let config = configuration {
            self.configuration = config
        }
        
        if title != nil {
            titleLabel.font = self.configuration.titleFont
            titleLabel.text = title
            titleLabel.textColor = self.configuration.titleColor
            titleLabel.textAlignment = self.configuration.isRTL ? .right : .left
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.width.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
            }
        }
        
        container = UIView()
        container.isUserInteractionEnabled = true
        container.layer.borderWidth = self.configuration.borderWidth
        container.layer.cornerRadius = self.configuration.cornerRadius
        container.layer.borderColor = self.configuration.borderColor.cgColor
        addSubview(container)
        container.snp.makeConstraints { [weak self] (make) in
            guard let self = self else { return }
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            if title == nil {
                make.top.equalToSuperview()
            } else {
                make.top.equalTo(self.titleLabel.snp.bottom).offset(9)
            }
            make.height.equalTo(56)
            make.bottom.equalToSuperview()
        }
        
        
        txtField = UITextField()
        txtField.font = self.configuration.valueFont
        txtField.textAlignment = self.configuration.isRTL ? .right : .left
        txtField.isUserInteractionEnabled = false
        txtField.placeholder = placeholder
        txtField.textColor = self.configuration.titleColor
        container.addSubview(txtField)
        txtField.snp.makeConstraints { (make) in
            if self.configuration.isRTL {
                make.right.equalToSuperview().inset(16)
                make.left.equalToSuperview().offset(40)
            } else {
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().inset(40)
            }
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
        let icon = UIImageView()
        if #available(iOS 13.0, *) {
            icon.image =  UIImage(named: self.configuration.icon, in: .module, with: .none)
        } else {
            icon.image = UIImage(named: self.configuration.icon)
        }
        container.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
            if self.configuration.isRTL {
                make.left.equalToSuperview().offset(16)
            } else {
                make.right.equalToSuperview().inset(16)
            }
        }
        
        loading.hidesWhenStopped = true
        loading.style = self.configuration.loadingIndicatorStyle
        container.addSubview(loading)
        loading.snp.makeConstraints { (make) in
            if self.configuration.isRTL {
                make.right.equalToSuperview().inset(16)
            } else {
                make.left.equalToSuperview().offset(16)
            }
            make.centerY.equalToSuperview()
        }
        
        
        if let iconValue = iconValue {
            
            container.addSubview(iconView)
            iconView.image = UIImage(named: iconValue)
            iconView.snp.makeConstraints { (make) in
                make.width.equalTo(36)
                make.height.equalTo(25)
                make.centerY.equalToSuperview()
                if self.configuration.isRTL {
                    make.right.equalToSuperview().inset(16)
                } else {
                    make.left.equalToSuperview().offset(16)
                }
            }
            
            
            txtField.snp.remakeConstraints { (make) in
                if self.configuration.isRTL {
                    make.right.equalTo(iconView.snp.left).offset(-8)
                    make.left.equalToSuperview().offset(40)
                } else {
                    make.left.equalTo(iconView.snp.right).offset(8)
                    make.right.equalToSuperview().inset(40)
                }
                make.centerY.equalToSuperview()
                make.height.equalToSuperview()
            }
        }
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setValue(value: String?) {
        txtField.text = value
    }
    
    public func setTitle(value: String?) {
        titleLabel.text = value
    }
    
    public func reloadData() {
        items = dataSource?.items(self)
        hideLoading()
        
        guard tapped == true else {
            return
        }
        openPanModal()
    }
    
}

extension SwiftyDorpdown {
    
    @objc
    private func dropDownDidTap() {
        tapped = true
        delegate?.dropdownViewDidTap?(self)
        guard let dataSource = dataSource?.items(self) else {
            showLoading()
            return
        }
        
        items = dataSource
        openPanModal()
    }
    
    private func showLoading() {
        txtField.isHidden = true
        iconView.isHidden = true
        loading.startAnimating()
    }
    
    private func hideLoading() {
        txtField.isHidden = false
        iconView.isHidden = false
        loading.stopAnimating()
    }
    
    private func openPanModal() {
        
        let page = DropdownItemsViewController(configuration: self.configuration, itemDidSelect: { [weak self] (item) in
            guard let self = self else {
                return
            }
            self.delegate?.dropdownDidSelectItem?(self, item: item)
            self.selectedItem = item
            self.setValue(value: item?.title)
            self.iconView.image = UIImage(named: item?.icon ?? "")
        })
        page.title = titleLabel.text
        page.dataSource = self.items
        viewContainingController?.presentPanModal(page)
    }
    
    private func registerTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropDownDidTap))
        addGestureRecognizer(tapGesture)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension UIView {
    
    public var viewContainingController : UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
}
