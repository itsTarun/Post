//
//  UserPostModel.swift
//  Social posts

import Foundation
import FirebaseFirestore

class UserPostModel {
    var userName  : String
    var timestamp : Timestamp
    var postTxt : String
    var numOfLikes : Int
    var category : String
    var documentId: String
    //var numOfComments : Int

    public init (name: String,timeStamp: Timestamp,postText: String, numberOfLikes: Int, postCategory: String,documentID: String){
        self.userName = name
        self.timestamp = timeStamp
        self.postTxt = postText
        self.numOfLikes = numberOfLikes
        self.category = postCategory
        self.documentId = documentID
        //self.numOfComments = numberOfComments
    }
}
