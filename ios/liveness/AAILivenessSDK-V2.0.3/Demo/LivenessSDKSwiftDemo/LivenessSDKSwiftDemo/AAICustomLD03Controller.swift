//
//  AAICustomLD03Controller.swift
//  LivenessSDKSwiftDemo
//
//  Created by advance on 2022/12/7.
//

import Foundation
import AAILiveness
import UIKit

class AAICustomLD03Controller: AAILivenessViewController {
    private var _myViewfinder: CAShapeLayer?
    private var _myTitleLabel: UILabel?
    private var _myImgBorderView: UIImageView?
    
    override func livenessWrapViewDidLoad(_ wrapView: AAILivenessWrapView) {
        super.livenessWrapViewDidLoad(wrapView)
        
        // Subclass can override this method to customize the UI
//        wrapView.backgroundColor = .gray
//        wrapView.roundBorderView.layer.borderColor = UIColor.red.cgColor;
//        wrapView.roundBorderView.layer.borderWidth = 2
        
        // Custom corner radius and the shape of the preview area
        let cornerRadius: CGFloat = 0;
        wrapView.roundBorderView.layer.cornerRadius = cornerRadius
        
        wrapView.configAvatarPreviewPathV2 = {(avatarPreviewFrame: CGRect, originRectPath: UIBezierPath, originWrapView: AAILivenessWrapView) in
            let squarePath = UIBezierPath(roundedRect: avatarPreviewFrame, cornerRadius: cornerRadius)
            originRectPath.append(squarePath.reversing())
        }
        
        /*
        //Custom preview area margin top
        wrapView.configAvatarPreviewMarginTop = {(wrapViewFrame) in
            return 64
        }
        */
        
        /*
        //Custom preview area width
        wrapView.configAvatarPreviewWidth = {(wrapViewFrame) in
            return 300
        }
        */
        
        /*
        // Configure roundBorderView or hide it or add your own if needed
        wrapView.roundBorderView.isHidden = true
         */
    }
    
    
    
    override func loadAdditionalUI() {
        super.loadAdditionalUI()
        
        // Configure your own UI
        // e.g. Remove UI controls that are not important to you.
        if let stateImgView = self.value(forKey: "_stateImgView") as? UIImageView {
            stateImgView.isHidden = true
        }
        
        if let timeLabel = self.value(forKey: "_timeLabel") as? UILabel {
            timeLabel.textColor = .blue
            timeLabel.layer.borderColor = UIColor.black.cgColor
        }
        
        if let stateLabel = self.value(forKey: "_stateLabel") as? UILabel {
            stateLabel.textColor = .black
        }
        
        if let voiceBtn = self.value(forKey: "_voiceBtn") as? UIButton {
            voiceBtn.removeFromSuperview()
        }
        
        if let backBtn = self.value(forKey: "_backBtn") as? UIButton {
            if let backBtnImg = backBtn.image(for: .normal) {
                let newBackBtnImg = backBtnImg.withRenderingMode(.alwaysTemplate)
                backBtn.setImage(newBackBtnImg, for: .normal)
                backBtn.tintColor = .red
            }
        }
        
        let myTitleLabel = UILabel()
        myTitleLabel.textColor = .green
        myTitleLabel.textAlignment = .center
        myTitleLabel.text = self.title
        self.view.addSubview(myTitleLabel)
        _myTitleLabel = myTitleLabel
        
        let imgBorderView = UIImageView()
        imgBorderView.layer.borderColor = UIColor.blue.cgColor
        imgBorderView.layer.borderWidth = 2
        self.view.addSubview(imgBorderView)
        _myImgBorderView = imgBorderView
    }
    
    override func layoutAdditionalUI() {
        super.layoutAdditionalUI()
        
        guard let backBtn = self.value(forKey: "_backBtn") as? UIButton else {
            return
        }
        
        guard let timeLabel = self.value(forKey: "_timeLabel") as? UILabel else {
            return
        }
        
        // Ajust UI
        let offsetY: CGFloat = 10
        var originFrame = backBtn.frame
        originFrame.origin.y -= offsetY;
        backBtn.frame = originFrame;
        
        originFrame = timeLabel.frame;
        originFrame.origin.y -= offsetY;
        timeLabel.frame = originFrame;
        
        let sw = self.view.frame.size.width
        
        let titleLabelBound = CGRect(x: 0, y: 0, width: (sw - backBtn.frame.maxX * 2), height: backBtn.frame.size.height)
        _myTitleLabel?.bounds = titleLabelBound
        _myTitleLabel?.center = CGPoint(x: sw/2, y: backBtn.center.y)
        
        guard let roundViewFrame = self.value(forKey: "_roundViewFrame") as? CGRect else {
            return
        }
        _myImgBorderView?.frame = roundViewFrame
    }
    
    override func tapBackBtnAction() {
        // Customize the back button logic
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
