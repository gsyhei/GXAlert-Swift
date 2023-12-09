//
//  MenuVieiw.swift
//  GXAlertSample
//
//  Created by Gin on 2020/11/18.
//

import UIKit

class MenuView: UIView {
    
    private lazy var tableView: UITableView = {
        let tabView = UITableView(frame: self.bounds, style: .plain)
        tabView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabView.rowHeight = 50.0
        tabView.dataSource = self
        tabView.delegate = self

        return tabView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
        self.addSubview(self.tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NSLog("MenuView deinit")
    }
}

extension MenuView: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellID: String = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        cell?.textLabel?.text = String(format: "ITEM %02d", indexPath.row)
        
        return cell!
    }
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
