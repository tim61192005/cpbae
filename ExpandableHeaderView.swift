//
//  ExpandableHeaderView.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/20.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit



protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
   var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.init(displayP3Red: 240/255, green: 200/255, blue: 0, alpha: 1)
        self.contentView.backgroundColor = UIColor.black
    }
}
