//
//  File.swift
//  
//
//  Created by MohammadReza Khatibi on 12/27/20.
//

import UIKit
import PanModal


class DropdownItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,PanModalPresentable {
    
    public var configuration = DropdownConfiguration()
    fileprivate var itemDidSelect   : (_ item: DropdownItem?) -> ()?
    fileprivate lazy var tableView   : UITableView = {
        let tableView = UITableView()
        tableView.register(DropdownCell.self, forCellReuseIdentifier: DropdownCell.reuseIdentifier)
        tableView.register(DropdownWithImageCell.self, forCellReuseIdentifier: DropdownWithImageCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    public var dataSource      : [DropdownItem]? {
        didSet {
            tableView.reloadData()
        }
    }

    init(configuration: DropdownConfiguration, itemDidSelect: @escaping (_ value: DropdownItem?) -> ()) {
        
        self.itemDidSelect = itemDidSelect
        super.init(nibName: nil, bundle: nil)
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard let _ = dataSource?[indexPath.row].icon else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DropdownCell.reuseIdentifier, for: indexPath) as? DropdownCell else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                return cell
            }
            cell.configuration = configuration
            cell.item = dataSource?[indexPath.row]
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropdownWithImageCell.reuseIdentifier, for: indexPath) as? DropdownWithImageCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            return cell
        }
        cell.configuration = configuration
        cell.item = dataSource?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemDidSelect(dataSource?[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(min(tableView.contentSize.height, 250))
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(tableView.contentSize.height)
    }
    
}
