//
//  TextFormat.swift
//  MovieApp
//
//  Created by ADMIN on 12/20/17.
//  Copyright © 2017 ADMIN. All rights reserved.
//

import Foundation
class TextFormat{
    func filterTextToEN(text: String)-> String{
        let text1 = text.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        let text2 = text1.replacingOccurrences(of: "[âấầẩậẫăắằẳặẵ]", with: "a", options: .regularExpression)
        let text3 = text2.replacingOccurrences(of: "đ", with: "d", options: .regularExpression)
        let text4 = text3.replacingOccurrences(of: "[êếềểệễ]", with: "e", options: .regularExpression)
        let text5 = text4.replacingOccurrences(of: "[ưứừửựữ]", with: "u", options: .regularExpression)
        let text6 = text5.replacingOccurrences(of: "[ôốồổộỗ]", with: "o", options: .regularExpression)
        let text7 = text6.replacingOccurrences(of: "[àáảạã]", with: "a", options: .regularExpression)
        let text8 = text7.replacingOccurrences(of: "[èéẻẹẽ]", with: "e", options: .regularExpression)
        let text9 = text8.replacingOccurrences(of: "[ùúủụũ]", with: "u", options: .regularExpression)
        let text10 = text9.replacingOccurrences(of: "[íìịỉĩ]", with: "i", options: .regularExpression)
        let text11 = text10.replacingOccurrences(of: "[òóỏọõ]", with: "o", options: .regularExpression)
        let text12 = text11.replacingOccurrences(of: "[ắằẳặẵ]", with: "a", options: .regularExpression)

        return text12
    }
}
