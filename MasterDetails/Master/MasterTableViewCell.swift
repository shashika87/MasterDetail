//
//  MasterTableViewCell.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    var imageViewUID = UIImageView()
    var labelUID: UILabel = UILabel()
    let activityViewIndicator = UIActivityIndicatorView()
    var leftXThumbNailConstraint : NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor=UIColor(red: CGFloat(87/255.0), green: CGFloat(182/255.0), blue: CGFloat(183/255.0), alpha: CGFloat(1.0))
        
        let leftMarginSpace = CGFloat(10)
        
        
        self.contentView.addSubview(self.imageViewUID)
        imageViewUID.translatesAutoresizingMaskIntoConstraints = false
        
        leftXThumbNailConstraint = NSLayoutConstraint(item:  self.imageViewUID   ,
                                                      attribute: .left,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem:self.contentView,
                                                      attribute: .left,
                                                      multiplier: 1, constant: leftMarginSpace)
        
        let topYThumbNailConstraint =  NSLayoutConstraint(item:  self.imageViewUID,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: self.contentView,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: 0.0)
        
        let widthThumbNailConstraint = NSLayoutConstraint(item: self.imageViewUID,
                                                          attribute: NSLayoutConstraint.Attribute.width,
                                                          relatedBy: NSLayoutConstraint.Relation.equal,
                                                          toItem: nil,
                                                          attribute:NSLayoutConstraint.Attribute.notAnAttribute,
                                                          multiplier: 1,
                                                          constant: 40)
        
        let heightThumbNailConstraint = NSLayoutConstraint(item: self.imageViewUID,
                                                           attribute: NSLayoutConstraint.Attribute.height,
                                                           relatedBy: NSLayoutConstraint.Relation.equal,
                                                           toItem: nil,
                                                           attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                           multiplier: 1,
                                                           constant: 40)
        
        self.contentView.addConstraints([leftXThumbNailConstraint, topYThumbNailConstraint, widthThumbNailConstraint, heightThumbNailConstraint])
        
        activityViewIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityViewIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityViewIndicator.startAnimating()
        
        imageViewUID.addSubview(activityViewIndicator)
        
        
        let activityCenterX = NSLayoutConstraint(item: activityViewIndicator,
                                                 attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.centerX,
                                                 multiplier: 1, constant: 0)
        let activityTop = NSLayoutConstraint(item: activityViewIndicator,
                                             attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.centerY,
                                             multiplier: 1, constant: 0)
        let activityWidth = NSLayoutConstraint(item: activityViewIndicator,
                                               attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                               multiplier: 1, constant: 30)
        let activityHeight = NSLayoutConstraint(item: activityViewIndicator,
                                                attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                multiplier: 1, constant: 30)
        
        self.addConstraints([activityCenterX, activityTop, activityWidth, activityHeight])
        
        labelUID.textColor = UIColor.white
        labelUID.font = UIFont.boldSystemFont(ofSize: 12);
        labelUID.translatesAutoresizingMaskIntoConstraints = false
        labelUID.numberOfLines = 0
        labelUID.sizeToFit()
        self.contentView.addSubview(labelUID)
        
        let leftXUIDConstraint = NSLayoutConstraint(item:  self.labelUID   ,
                                                    attribute: .left,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: self.imageViewUID,
                                                    attribute: .right,
                                                    multiplier: 1, constant: leftMarginSpace)
        
        let topYUIDConstraint = NSLayoutConstraint(item:  self.labelUID,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: self.contentView,
                                                    attribute: .centerY,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        let widthUIDConstraint = NSLayoutConstraint(item: labelUID,
                                                    attribute: NSLayoutConstraint.Attribute.width,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: nil,
                                                    attribute:NSLayoutConstraint.Attribute.notAnAttribute,
                                                    multiplier: 1,
                                                    constant: 150)
        
        let heightUIDConstraint = NSLayoutConstraint(item: labelUID,
                                                     attribute: NSLayoutConstraint.Attribute.height,
                                                     relatedBy: NSLayoutConstraint.Relation.equal,
                                                     toItem: nil,
                                                     attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                     multiplier: 1,
                                                     constant: 30)
        
        self.contentView.addConstraints([leftXUIDConstraint, topYUIDConstraint, widthUIDConstraint, heightUIDConstraint])
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
