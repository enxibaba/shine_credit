//
//  ViewController.swift
//  LivenessSDKSwiftDemo
//
//  Created by advance on 2021/7/21.
//

import UIKit
import AAILiveness

class ViewController: UIViewController {
    private var _testType: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Init SDK
        AAILivenessSDK.initWith(.indonesia)
        // Configure SDK
        /*
        AAILivenessSDK.configResultPictureSize(300)
        */
        
        /*
        // Set whether to detect face occlusion. The default value is NO.
        AAILivenessSDK.configDetectOcclusion(true)
        */
        
        /*
        // Set action detection time interval. Default is 10s.
        AAILivenessSDK.configActionTimeoutSeconds(10)
        */
        
        /*
        let additionalConfig = AAILivenessSDK.additionalConfig();
        // Set the color of the round border in the avatar preview area. Default is clear color.
        // additionalConfig.roundBorderColor = UIColor(red: 0.36, green: 0.768, blue: 0.078, alpha: 1)

        // Set the color of the ellipse dashed line that appears during the liveness detection. Default is white color.
        // additionalConfig.ellipseLineColor = .green

        // Set the level of liveness detection. Default is AAIDetectionLevelNormal.
        // Available levels are AAIDetectionLevelEasy, AAIDetectionLevelNormal, AAIDetectionLevelHard
        // The harder it is, the stricter the verification is.
        // additionalConfig.detectionLevel = .normal;
        */
        
        let label = UILabel(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 40))
        label.text = "SDK version: \(AAILivenessSDK.sdkVersion())"
        self.view.addSubview(label)
        
        self.addButton("Default test", CGRect(x: 40, y: 140, width: 140, height: 40), #selector(tapSDKBtnAction))
        self.addButton("CustomUI test 03", CGRect(x: 40, y: 200, width: 200, height: 40), #selector(tapCustomUIBtn03Action))
    }
    
    func addButton(_ title: String, _ frame: CGRect, _ action: Selector) {
        let btn = UIButton(type: .custom)
        btn.frame = frame
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
        self.view.addSubview(btn)
    }

    @objc func tapSDKBtnAction() {
        _testType = 0
        self.checkLicenseAndShowSDK()
    }
    
    @objc func tapCustomUIBtn03Action() {
        _testType = 3
        self.checkLicenseAndShowSDK()
    }
    
    func checkLicenseAndShowSDK() {
        // Load License
        /*
         The license content is obtained by your server calling our openapi.
         In order to facilitate the demonstration of this SDK, we directly put the content of the license into the file, in fact, you should call your server api to get the license content.
         */
        guard let path = Bundle.main.path(forResource: "SDK-DEMO-LICENSE", ofType: nil) else {
            print("SDK-DEMO-LICENSE file not exist!")
            return
        }

        var demoLicenseContent = ""
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            demoLicenseContent = content
        } catch {}

        let checkResult = AAILivenessSDK.configLicenseAndCheck(demoLicenseContent)
        if checkResult == "SUCCESS" {
            // license is valid, show SDK page
            self.showSDK()
        } else if checkResult == "LICENSE_EXPIRE" {
            print("LICENSE_EXPIRE: please call your server's api to generate a new license")
        } else if checkResult == "APPLICATION_ID_NOT_MATCH" {
            print("APPLICATION_ID_NOT_MATCH: please bind your app's bundle identifier on our cms website, then recall your server's api to generate a new license")
        } else {
            print("\(checkResult)")
        }
    }
    
    func showSDK() {
        // Demo: Push default liveness view controller
        if _testType == 0 {
            let vc = AAILivenessViewController()
            vc.detectionSuccessBlk = {(rawVC, result) in
                let livenessId = result.livenessId
                let bestImg = result.img
                let size = bestImg.size
                print(">>>>>livenessId: \(livenessId), imgSize: \(size.width), \(size.height)")
                // Do something... (e.g., call anti-spoofing api to get score)
                
                rawVC.navigationController?.popViewController(animated: true)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // Demo: Present custom liveness view controller
        if _testType == 3 {
            let vc = AAICustomLD03Controller()
            vc.title = "Take a Selfie"
            vc.detectionSuccessBlk = {(rawVC, result) in
                let livenessId = result.livenessId
                let bestImg = result.img
                let size = bestImg.size
                print(">>>>>livenessId: \(livenessId), imgSize: \(size.width), \(size.height)")
                // Do something... (e.g., call anti-spoofing api to get score)
                
                rawVC.presentingViewController?.dismiss(animated: true, completion: nil)
            }
            
            let navc = UINavigationController(rootViewController: vc)
            navc.isNavigationBarHidden = true
            navc.modalPresentationStyle = .fullScreen
            self.present(navc, animated: true, completion: nil)
        }
    }

    
}

