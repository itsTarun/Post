//
//  NetworkAPI.swift
//  Social posts

import Foundation
import FirebaseFirestore

class NetworkManager {
    public static let  dataBaseRef =  Firestore.firestore()
    public static let sharedInstance = NetworkManager()

    private init() {

    }
    private func getAllPostsAsDictionary(complitionHandler: @escaping ([QueryDocumentSnapshot]) -> Void) {
        NetworkManager.dataBaseRef.collection(PostConstants.postCollectionRef).getDocuments { (querySnapShot, error) in
            if let error = error {
                print(error)
            } else {
                complitionHandler((querySnapShot?.documents)!)

            }
        }
    }

    func getAllPosts(complitionHandler: @escaping ([UserPostModel])->Void) {
        getAllPostsAsDictionary { (queryData) in
            var mList = [UserPostModel]()
            
            if queryData.count > 0 {
                for i in 0...queryData.count - 1 {
                    let demo = queryData[i].data()
                    let userPost = UserPostModel.init(name: demo[PostConstants.userName] as! String,
                                                      timeStamp:demo[PostConstants.timeStamp] as! Timestamp,
                                                      postText: demo[PostConstants.postText] as! String,
                                                      numberOfLikes: demo[PostConstants.numOfLikes] as! Int, postCategory: demo[PostConstants.category] as! String, documentID: queryData[i].documentID)
                    mList.append(userPost)

                }
            }
            complitionHandler(mList)
        }
    }

    func updateDocument(userPostData : UserPostModel)  {
        NetworkManager.dataBaseRef.collection(PostConstants.postCollectionRef).document(userPostData.documentId).updateData([PostConstants.numOfLikes:userPostData.numOfLikes])
    }
}
