//
//  HotTagModel.swift
//  FlickrGallery
//
//  Created by Wesam Khallaf on 12/07/2022.
//

import SwiftUI

struct HotTagModel  : Codable{
    
    let period : String
    let count : Int
    let hottags : HotTag
    
}
struct HotTag : Codable {
    let tag : [Tag]
}
struct Tag : Codable   {
    let _content : String
    let thm_data : Thm_Data
}
struct Thm_Data : Codable {
    let photos : TagPhotos
}

    struct TagPhotos : Codable {
        let photo : [PhotoUrlInfos]  // from FlickrDataOfSearchMethod
    }


/*
 { "period": "day", "count": 30, "hottags": {
     "tag": [
       { "_content": "coast",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "22826315758", "secret": "27e07c5afb", "server": "5325", "farm": 6, "owner": "47290259@N06", "username": "", "title": "The Cliffed  coast at Groemitz at  the  Baltic  Sea", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "blackwhite",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "26132580771", "secret": "4d59da5de8", "server": "1596", "farm": 2, "owner": "96442732@N03", "username": "", "title": "In Her Eyes  { A Judith Blossom }", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "longexposure",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "30771343890", "secret": "4159bce4c1", "server": "5618", "farm": 6, "owner": "96442732@N03", "username": "", "title": "I Dream in Coloûr~", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "dog",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "30412622344", "secret": "48f5af2e2d", "server": "5650", "farm": 6, "owner": "87185102@N00", "username": "", "title": "the fence............", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "sunlight",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "30927416960", "secret": "791c90b4d3", "server": "5693", "farm": 6, "owner": "28429128@N05", "username": "", "title": "The glorious, golden glow of Autumn light.", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "finistère",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "29490008681", "secret": "b1622e8314", "server": "8126", "farm": 9, "owner": "100112015@N06", "username": "", "title": "Le Fort des Capucins #2", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "waterfall",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "21456642814", "secret": "cb5d406eb7", "server": "5798", "farm": 6, "owner": "77176980@N06", "username": "", "title": "Whatcom Falls, Washington", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "newmexico",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "29921129291", "secret": "90c4f28ca1", "server": "8492", "farm": 9, "owner": "68151761@N05", "username": "", "title": "high desert sunshine", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "summertime",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "31552648403", "secret": "3f937146dd", "server": "488", "farm": 1, "owner": "91619997@N04", "username": "", "title": "Memory", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "darktable",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "28987014143", "secret": "341b7ddd9b", "server": "8210", "farm": 9, "owner": "138284229@N02", "username": "", "title": "", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "papillon",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "29491967761", "secret": "fac5be032d", "server": "7477", "farm": 8, "owner": "96444540@N06", "username": "", "title": "Azuré des nerpruns (3)1009", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "fireworks",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "31150773003", "secret": "39a93727b8", "server": "360", "farm": 1, "owner": "24544649@N06", "username": "", "title": "Gott Nytt År !", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "forest",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "31475674174", "secret": "af83fe40f6", "server": "471", "farm": 1, "owner": "133889206@N06", "username": "", "title": "Anybody in there?", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "afrika",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "25110694836", "secret": "2de9b62bbd", "server": "1554", "farm": 2, "owner": "14974601@N06", "username": "", "title": "The long shadow", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "coneflowers",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "31107881716", "secret": "b64032a73e", "server": "5835", "farm": 6, "owner": "65416880@N00", "username": "", "title": "swing ... to another dimension", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "grandcanyon",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "26480061714", "secret": "0c2ac0a117", "server": "7226", "farm": 8, "owner": "8935325@N08", "username": "", "title": "Fishing the Grand Canyon", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "atardecer",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "27120189571", "secret": "24797c2832", "server": "7440", "farm": 8, "owner": "43589035@N06", "username": "", "title": "Sunset desert.", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "deutschland",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "30678806443", "secret": "e6fbd499d7", "server": "5600", "farm": 6, "owner": "47290259@N06", "username": "", "title": "Autumn Beauty", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "ccby",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "52141541612", "secret": "69ef49c52a", "server": "65535", "farm": 66, "owner": "105105658@N03", "username": "", "title": "After the rain", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "shetland",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "27927269614", "secret": "69bf17a783", "server": "8755", "farm": 9, "owner": "12070225@N03", "username": "", "title": "Cliff top", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "amazing",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "25399735575", "secret": "b9a7b58130", "server": "1604", "farm": 2, "owner": "59829258@N06", "username": "", "title": "A New Zealand landscape -10", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "spruceknob",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "51623407423", "secret": "50770c0bf7", "server": "65535", "farm": 66, "owner": "72141975@N06", "username": "", "title": "Spruce Knob Morning", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "waddenisland",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "51008551623", "secret": "32c8333997", "server": "65535", "farm": 66, "owner": "185013827@N07", "username": "", "title": "Stay away from me........", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "soleilparisien",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "52206139941", "secret": "dee780d2b3", "server": "65535", "farm": 66, "owner": "106123975@N05", "username": "", "title": "Soleil parisien. *", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "alkmaar",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "28166107893", "secret": "6f31640a12", "server": "8659", "farm": 9, "owner": "96667746@N04", "username": "", "title": "I'm Cloudbusting Daddy!", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "greatsanddunesnp",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "52160918623", "secret": "1a4fb9814d", "server": "65535", "farm": 66, "owner": "39027998@N02", "username": "", "title": "To find a form that accommodates the mess, that is the task of the artist now…", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "analogfilm",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "21428300514", "secret": "4aeb8b4cd8", "server": "5754", "farm": 6, "owner": "40834417@N08", "username": "", "title": "Autumn- Sun", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "strand",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "22826315758", "secret": "27e07c5afb", "server": "5325", "farm": 6, "owner": "47290259@N06", "username": "", "title": "The Cliffed  coast at Groemitz at  the  Baltic  Sea", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "nocturnas",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "31423593775", "secret": "8d856a20d6", "server": "5596", "farm": 6, "owner": "66403925@N03", "username": "", "title": "Coruja-das-torres, Barn Owl (Tyto alba)", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } },
       { "_content": "naturaufnahmen",
         "thm_data": {
           "photos": {
             "photo": [
               { "id": "49535171258", "secret": "e594c9ca41", "server": "65535", "farm": 66, "owner": "55542027@N05", "username": "", "title": "Das Hochwasser ist schön", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
             ] } } }
     ] }, "stat": "ok" }
 */
