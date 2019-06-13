//
//  UITableView.swift
//  Esaad
//
//  Created by Usman on 28/01/2019.
//  Copyright © 2019 Faraz Haider. All rights reserved.
//

import Foundation

extension UITableView {

    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message.localized
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Dubai-Bold", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    
    func setEmptyMessageTo(hide : Bool){
        for view in self.subviews{
            if view is EmptyDataSetView{
                DispatchQueue.main.async {
                    view.isHidden = hide
                }
            }
        }
    }

    func setEmptyMessage() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "dealplaceholder" + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "-ar") )
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("defaultEmptyTitle")
        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    

    func setEmptyMessageForFavList() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "favplaceholder"  + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "-ar"))
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("favEmptyTitle")
        view.detailLabel.text = Utility.getLocalizedString("favEmptyMsg")
//        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    
    func setEmptyMessageForFilter() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "dealplaceholder"  + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "ar"))
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("defaultEmptyTitle")
        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    
    func removeEmptyMessage() {
        for view in self.subviews{
            if view is EmptyDataSetView{
                DispatchQueue.main.async {
                    view.removeFromSuperview()
                }
            }
        }
       
    }
    
}

extension UICollectionView {
    
    func setEmptyDataMessage(_ message: String = "No data found") {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message.localized
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Dubai-Bold", size: 20)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func setEmptyMessageTo(hide : Bool){
        for view in self.subviews{
            if view is EmptyDataSetView{
                DispatchQueue.main.async {
                    view.isHidden = hide
                }
            }
        }
    }
    
    func setEmptyMessage() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "dealplaceholder"  + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "ar"))
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("defaultEmptyTitle")
        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    
    func setEmptyMessageForFavList() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "favplaceholder"  + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "ar"))
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("favEmptyTitle")
        view.detailLabel.text = Utility.getLocalizedString("favEmptyMsg")
//        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    
    func setEmptyMessageForFilter() {
        let view : EmptyDataSetView = UIView.fromNib()
        view.frame = self.bounds
        view.center = self.convert(self.center, from:self.superview)
        view.bannerImg.image = UIImage(named: "dealplaceholder"  + (Singleton.sharedInstance.isEnglishLanguageSelected ? "" :  "ar"))
        view.bannerImg.contentMode = .scaleAspectFit
        view.titleLabel.text = Utility.getLocalizedString("defaultEmptyTitle")
        view.detailLabel.isHidden = true
        self.addSubview(view)
    }
    
    func removeEmptyMessage() {
        for view in self.subviews{
            if view is EmptyDataSetView{
                DispatchQueue.main.async {
                    view.removeFromSuperview()
                }
            }
        }
        
    }
    
}

