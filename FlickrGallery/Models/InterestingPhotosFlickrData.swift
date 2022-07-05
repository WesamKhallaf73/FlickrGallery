//
//  InterestingPhotosFlickrData.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 05/07/2022.
//

import SwiftUI

struct InterestingPhotosFlickrData : Codable {
    let photos : MainInteresting
}

struct MainInteresting : Codable {
    let page : Int?
    let pages : Int?
    let perPage : Int?
    let total : Int?
    let photo : [PhotoUrlInfos]  // definned in from FlickrDataOfSearchMethod file
}



/*
 { "photos": { "page": 1, "pages": 5, "perpage": 100, "total": "500",
     "photo": [
       { "id": "52193352279", "owner": "101058950@N02", "secret": "3e878b9b6b", "server": "65535", "farm": 66, "title": "Towering the Wetlands", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52191996640", "owner": "154175074@N07", "secret": "b91e7a1967", "server": "65535", "farm": 66, "title": "Geai des chênes", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52192984450", "owner": "32452368@N05", "secret": "f4ea4f9ec7", "server": "65535", "farm": 66, "title": "Finale", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52193402329", "owner": "126113035@N03", "secret": "959284d902", "server": "65535", "farm": 66, "title": "Landscape of nature and water", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52191619438", "owner": "82664172@N00", "secret": "22987d9fd8", "server": "65535", "farm": 66, "title": "Dark Fjord Rain", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52189849392", "owner": "187786900@N03", "secret": "a53288da1d", "server": "65535", "farm": 66, "title": "Look at My Armor", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52190541272", "owner": "21028294@N06", "secret": "b65e1f6e52", "server": "65535", "farm": 66, "title": "Iberis sempervirens", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52192984168", "owner": "137534856@N08", "secret": "72aec812ea", "server": "65535", "farm": 66, "title": "Ecluse de Gay Canal du midi", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52192582246", "owner": "183875547@N07", "secret": "a29094b96b", "server": "65535", "farm": 66, "title": "Narciso.", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52191349302", "owner": "126889546@N08", "secret": "a4f3466691", "server": "65535", "farm": 66, "title": "Midsummer", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "52192730548", "owner": "127753524@N02", "secret": "912e809951", "server": "65535", "farm": 66, "title": "", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
       { "id": "521927
 */
