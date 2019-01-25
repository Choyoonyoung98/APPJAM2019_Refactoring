//
//  ImageViewURLExtension.swift
//  DowaDog
//
//  Created by 조윤영 on 06/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        
        let defaultImg = UIImage(named: defaultImgPath)
        //혹시나 오류가 발생한 경우 defualtImg 를 출력
        
        if let url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if url.isEmpty {                //  만약 이미지가 없는 경우
                self.image = defaultImg
            } else {                        // URL 에 존재하는 경우
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])        // Kingfisher 에서
            }
        } else {
            self.image = defaultImg
        }
    }
}

