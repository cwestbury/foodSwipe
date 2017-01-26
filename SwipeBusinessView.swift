//
//  SwipeBusinessView.swift
//  FoodSwipe
//
//  Created by Cameron Westbury on 1/25/17.
//  Copyright © 2017 Cameron Westbury. All rights reserved.
//

import UIKit
import MDCSwipeToChoose
import Kingfisher

class SwipeBusinessView: MDCSwipeToChooseView {
    
    let ChooseBusinessViewImageLabelWidth:CGFloat = 42.0;
    var business: Business!
    var informationView: UIView!
    var nameLabel: UILabel!
    var ratingImage: UIImageView!
    var carmeraImageLabelView:ImageLabelView!
    var interestsImageLabelView: ImageLabelView!
    var friendsImageLabelView: ImageLabelView!
    //    var businessImage : UIImage!
    
    init(frame: CGRect, business: Business, options: MDCSwipeToChooseViewOptions) {
        
        super.init(frame: frame, options: options)
        self.business = business
        
        if let image = self.business.businessImage {
            self.imageView.image = image
        }
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        UIViewAutoresizing.flexibleBottomMargin
        
        self.imageView.autoresizingMask = self.autoresizingMask
        constructInformationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func constructInformationView() -> Void{
        let bottomHeight:CGFloat = 60.0
        let bottomFrame:CGRect = CGRect(x: 0,
                                        y: self.bounds.height - bottomHeight,
                                        width: self.bounds.width,
                                        height: bottomHeight);
        self.informationView = UIView(frame:bottomFrame)
        self.informationView.backgroundColor = UIColor.white
        self.informationView.clipsToBounds = true
        self.informationView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleTopMargin]
        self.addSubview(self.informationView)
        constructNameLabel()
        constuctRatingImage()
        //        constructCameraImageLabelView()
        //        constructInterestsImageLabelView()
        //        constructFriendsImageLabelView()
    }
    
    func constructNameLabel() -> Void{
        let leftPadding:CGFloat = 12.0
        let topPadding:CGFloat = 00.0
        let frame:CGRect = CGRect(x: leftPadding,
                                  y: topPadding,
                                  width: floor(self.informationView.frame.width),
                                  height: self.informationView.frame.height - topPadding)
        self.nameLabel = UILabel(frame:frame)
        self.nameLabel.text = "\(business.name!), \(business.distance!)"
        self.informationView .addSubview(self.nameLabel)
    }
    
    func constuctRatingImage() -> Void {
        let leftPadding:CGFloat = 10.0
        let topPadding:CGFloat = self.imageView.frame.height - 30 - 10 - nameLabel.frame.height
        //        width: print(self.informationView.frame.width/2)
        let frame:CGRect = CGRect(x: leftPadding,
                                  y: topPadding,
                                  width: floor(167.5),
                                  height: 30)
        self.ratingImage = UIImageView(frame: frame)
        ratingImage.image = business.ratingImage
        ratingImage.layer.borderColor = UIColor.black.cgColor
        self.imageView.addSubview(self.ratingImage)
    }
    //
    func constructCameraImageLabelView() -> Void{
        var rightPadding:CGFloat = 10.0
        let image:UIImage = UIImage(named:"camera")!
        self.carmeraImageLabelView = buildImageLabelViewLeftOf(self.informationView.bounds.width, image:image, text:business.address!)
        self.informationView.addSubview(self.carmeraImageLabelView)
    }
    func constructInterestsImageLabelView() -> Void{
        let image: UIImage = UIImage(named: "book")!
        self.interestsImageLabelView = self.buildImageLabelViewLeftOf(self.carmeraImageLabelView.frame.minX, image: image, text:(business.reviewCount?.stringValue)!)
        self.informationView.addSubview(self.interestsImageLabelView)
    }
    
    func constructFriendsImageLabelView() -> Void{
        let image:UIImage = UIImage(named:"group")!
        self.friendsImageLabelView = buildImageLabelViewLeftOf(self.interestsImageLabelView.frame.minX, image:image, text:"No Friends")
        self.informationView.addSubview(self.friendsImageLabelView)
    }
    
    func buildImageLabelViewLeftOf(_ x:CGFloat, image:UIImage, text:String) -> ImageLabelView{
        let frame:CGRect = CGRect(x:x-ChooseBusinessViewImageLabelWidth, y: 0,
                                  width: ChooseBusinessViewImageLabelWidth,
                                  height: self.informationView.bounds.height)
        let view:ImageLabelView = ImageLabelView(frame:frame, image:image, text:text)
        view.autoresizingMask = UIViewAutoresizing.flexibleLeftMargin
        return view
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
