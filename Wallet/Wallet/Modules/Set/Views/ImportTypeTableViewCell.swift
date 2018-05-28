//
//  ImportTypeTableViewCell.swift
//  Wallet
//
//  Created by Maynard on 2018/3/8.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit
import Eureka
import HMSegmentedControl

open class ImportTypeTableViewCell<T: Equatable> : Cell<T>, CellType {
    
    @IBOutlet public weak var segmentedControl: HMSegmentedControl!
    @IBOutlet public weak var titleLabel: UILabel?
    
    private var dynamicConstraints = [NSLayoutConstraint]()
    fileprivate var observingTitleText = false
    private var awakeFromNibCalled = false
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let segmentedControl = HMSegmentedControl()
        segmentedControl.sectionTitles = ["11","22","33","44"]
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 2
        segmentedControl.selectionIndicatorColor = UIColor.mainNormalColor
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.subTitleColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.mainNormalColor, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        self.segmentedControl = segmentedControl
        
        self.titleLabel = self.textLabel
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.setContentHuggingPriority(UILayoutPriority(rawValue: 500), for: .horizontal)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { [weak self] _ in
            guard let me = self else { return }
            guard me.observingTitleText else { return }
            me.titleLabel?.removeObserver(me, forKeyPath: "text")
            me.observingTitleText = false
        }
        NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { [weak self] _ in
            guard let me = self else { return }
            guard !me.observingTitleText else { return }
            me.titleLabel?.addObserver(me, forKeyPath: "text", options: NSKeyValueObservingOptions.old.union(.new), context: nil)
            me.observingTitleText = true
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIContentSizeCategoryDidChange, object: nil, queue: nil) { [weak self] _ in
            self?.titleLabel = self?.textLabel
            self?.setNeedsUpdateConstraints()
        }
        contentView.addSubview(titleLabel!)
        contentView.addSubview(segmentedControl)
        titleLabel?.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
        observingTitleText = true
        imageView?.addObserver(self, forKeyPath: "image", options: [.old, .new], context: nil)
        
        contentView.addConstraint(NSLayoutConstraint(item: segmentedControl, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        awakeFromNibCalled = true
    }
    
    deinit {
        segmentedControl.removeTarget(self, action: nil, for: .allEvents)
        if !awakeFromNibCalled {
            if observingTitleText {
                titleLabel?.removeObserver(self, forKeyPath: "text")
            }
            imageView?.removeObserver(self, forKeyPath: "image")
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
            NotificationCenter.default.removeObserver(self, name: Notification.Name.UIContentSizeCategoryDidChange, object: nil)
        }
        
    }
    
    open override func setup() {
        super.setup()
        selectionStyle = .none
        segmentedControl.addTarget(self, action: #selector(ImportTypeTableViewCell.valueChanged), for: .valueChanged)
    }
    
    open override func update() {
        super.update()
        detailTextLabel?.text = nil
        
        updateSegmentedControl()
        segmentedControl.selectedSegmentIndex = selectedIndex() ?? UISegmentedControlNoSegment
        segmentedControl.isEnabled = !row.isDisabled
    }
    
    @objc func valueChanged() {
        row.value =  (row as! ImportTypeRow<T>).options?[segmentedControl.selectedSegmentIndex]
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let obj = object as AnyObject?
        
        if let changeType = change, let _ = keyPath, ((obj === titleLabel && keyPath == "text") || (obj === imageView && keyPath == "image")) &&
            (changeType[NSKeyValueChangeKey.kindKey] as? NSNumber)?.uintValue == NSKeyValueChange.setting.rawValue, !awakeFromNibCalled {
            setNeedsUpdateConstraints()
            updateConstraintsIfNeeded()
        }
    }
    
    func updateSegmentedControl() {
        segmentedControl.sectionTitles = (row as! ImportTypeRow<String>).options ?? []
    }
    
    open override func updateConstraints() {
        guard !awakeFromNibCalled else {
            super.updateConstraints()
            return
        }
        segmentedControl.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        super.updateConstraints()
    }
    
    func selectedIndex() -> Int? {
        guard let value = row.value else { return nil }
        return (row as! ImportTypeRow<T>).options?.index(of: value)
    }
}

// MARK: SegmentedRow

/// An options row where the user can select an option from an UISegmentedControl
public final class ImportTypeRow<T: Equatable>: OptionsRow<ImportTypeTableViewCell<T>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
