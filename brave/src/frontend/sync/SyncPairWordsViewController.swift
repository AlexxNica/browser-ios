//
//  SyncPairWordsViewController.swift
//  Client
//
//  Created by James Mudgett on 2/26/17.
//  Copyright © 2017 Brave Software. All rights reserved.
//

import UIKit
import Shared

class SyncPairWordsViewController: UIViewController {
    
    var containerView: UIView!
    var codewordsView: SyncCodewordsView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Strings.Sync
        view.backgroundColor = SyncBackgroundColor
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.whiteColor()
        view.addSubview(containerView)
        
        codewordsView = SyncCodewordsView()
        containerView.addSubview(codewordsView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightSemibold)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = "Add Device"
        view.addSubview(titleLabel)
        
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightRegular)
        descriptionLabel.textColor = UIColor(rgb: 0x696969)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .ByWordWrapping
        descriptionLabel.text = "Using a second device navigate to Brave Settings > Sync. Capture the QR Code (above) with second device, or enter code words if no camera is available."
        view.addSubview(descriptionLabel)
        
        doneButton = UIButton()
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightBold)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        doneButton.backgroundColor = BraveUX.DefaultBlue
        doneButton.layer.cornerRadius = 8
        view.addSubview(doneButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
