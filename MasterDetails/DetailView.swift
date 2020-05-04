//
//  DetailView.swift
//  MasterDetails
//
//  Created by Shashi Kant on 5/3/20.
//  Copyright © 2020 Shashi Kant. All rights reserved.
//

import UIKit

class DetailView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var client : HTTPClient!
    var uidItem : UIDItem!
    let imageView = UIImageView()
    var imageViewWidthConstraint : NSLayoutConstraint!
    var imageViewHeightConstraint : NSLayoutConstraint!
    let labelCategory = UILabel()
    let labelDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsUpdateConstraints()
              
              let activityViewIndicator = UIActivityIndicatorView()
              activityViewIndicator.translatesAutoresizingMaskIntoConstraints = false
              self.addSubview(imageView)

              imageView.addSubview(activityViewIndicator)
              let activityCenterX = NSLayoutConstraint(item: activityViewIndicator,
                                                       attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.centerX,
                                                       multiplier: 1, constant: 0)
              let activityTop = NSLayoutConstraint(item: activityViewIndicator,
                                                   attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: imageView, attribute: NSLayoutConstraint.Attribute.centerY,
                                                   multiplier: 1, constant: 0)
              let activityWidth = NSLayoutConstraint(item: activityViewIndicator,
                                                     attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                     multiplier: 1, constant: 300)
              let activityHeight = NSLayoutConstraint(item: activityViewIndicator,
                                                      attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                      multiplier: 1, constant: 400)
              
              self.addConstraints([activityCenterX, activityTop, activityWidth, activityHeight])
              
              
              
              imageView.translatesAutoresizingMaskIntoConstraints = false
              let horizontalConstraint = NSLayoutConstraint(item: imageView,
                                                            attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX,
                                                            multiplier: 1, constant: 0)
              let verticalConstraint = NSLayoutConstraint(item: imageView,
                                                          attribute: NSLayoutConstraint.Attribute.topMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.topMargin,
                                                          multiplier: 1, constant: 50)
              imageViewWidthConstraint = NSLayoutConstraint(item: imageView,
                                                            attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1, constant: 200)
              imageViewHeightConstraint = NSLayoutConstraint(item: imageView,
                                                             attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                             multiplier: 1, constant: 200)
        
              
              
              self.addConstraints([horizontalConstraint, verticalConstraint, imageViewWidthConstraint, imageViewHeightConstraint])
              
              
              labelCategory.textColor = UIColor(red: CGFloat(87/255.0), green: CGFloat(182/255.0), blue: CGFloat(183/255.0), alpha: CGFloat(1.0))
              labelCategory.text = "";
              labelCategory.font = UIFont.boldSystemFont(ofSize: 32);
              labelCategory.translatesAutoresizingMaskIntoConstraints = false
              self.addSubview(labelCategory)
              
              let categoryLeftXConstraint = NSLayoutConstraint(item: labelCategory,
                                                            attribute: NSLayoutConstraint.Attribute.centerX,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem:imageView,
                                                            attribute:NSLayoutConstraint.Attribute.centerX,
                                                            multiplier: 1, constant: 0)
              
              let categoryTop =              NSLayoutConstraint(item: labelCategory,
                                                             attribute: .top,
                                                             relatedBy: .equal,
                                                             toItem: imageView,
                                                             attribute: .bottom,
                                                             multiplier: 1.0,
                                                             constant: 20.0)
              
              let categoryWidthConstraint = NSLayoutConstraint(item: labelCategory,
                                                            attribute: NSLayoutConstraint.Attribute.width,
                                                            relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual,
                                                            toItem: nil,
                                                            attribute:NSLayoutConstraint.Attribute.notAnAttribute,
                                                            multiplier: 1,
                                                            constant: 80)
              
              let categoryHeightConstraint = NSLayoutConstraint(item: labelCategory,
                                                             attribute: NSLayoutConstraint.Attribute.height,
                                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                                             toItem: nil,
                                                             attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                             multiplier: 1,
                                                             constant: 23)
              
              self.addConstraints([categoryLeftXConstraint, categoryTop, categoryWidthConstraint, categoryHeightConstraint])
              
              labelDescription.text = ""
              labelDescription.textColor = UIColor(red: CGFloat(87/255.0), green: CGFloat(182/255.0), blue: CGFloat(183/255.0), alpha: CGFloat(1.0))
              labelDescription.text = labelDescription.text?.uppercased()
              labelDescription.font = UIFont.boldSystemFont(ofSize: 14);
              labelDescription.translatesAutoresizingMaskIntoConstraints = false
              labelDescription.numberOfLines = 0
              labelDescription.sizeToFit()
              self.addSubview(labelDescription)
              
              let descriptionLeft = NSLayoutConstraint(item: labelDescription,
                                                attribute: NSLayoutConstraint.Attribute.centerX,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem:imageView,
                                                attribute:NSLayoutConstraint.Attribute.centerX,
                                                multiplier: 1, constant: 0)
              
              let descriptionTop =              NSLayoutConstraint(item: labelDescription,
                                                            attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: labelCategory,
                                                            attribute: .bottom,
                                                            multiplier: 1.0,
                                                            constant: 10.0)
              
              let descriptionWidth = NSLayoutConstraint(item: labelDescription,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute:NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 120)
              
              let descriptionHeight = NSLayoutConstraint(item: labelDescription,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 40)
              
            self.addConstraints([descriptionLeft, descriptionTop, descriptionWidth, descriptionHeight])
              
            
    }
    
    func updateDetailView(_ uidItem: UIDItem){
        
     
        let url = URL(string:uidItem.path)!
            self.client.loadImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
              self!.imageView.image = imageData
              let imageHeight = Double((self?.frame.height)!)
              let imageRatio = Double((imageData.size.width)) / Double((imageData.size.height))
                                   let imageWidth = imageHeight*imageRatio
//              self?.imageViewWidthConstraint.constant = CGFloat(imageWidth)
//              self?.imageViewHeightConstraint.constant = CGFloat(imageHeight)
            case .failure(let error):
                print("the error \(error)")
            }
        }
        
        self.labelCategory.text = uidItem.category.joined(separator: ", ")
        self.labelDescription.text = uidItem.description
        
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

}
