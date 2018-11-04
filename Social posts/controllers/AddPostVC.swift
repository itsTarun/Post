//
//  AddPostVC.swift
//  Social posts

import UIKit
import FirebaseFirestore
class AddPostVC: UIViewController,UITextViewDelegate {
    //Outlets

    @IBOutlet weak var catogerySegment: UISegmentedControl!

    @IBOutlet weak var userNameText: UITextField!

    @IBOutlet weak var postText: UITextView!

    @IBOutlet weak var postButtonOutlet: UIButton!


    // variables
    private  var categorySelected : String = "Funny"
    private var FIRST_INSTALL = "firstInstall"


    ////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//      if  UserDefaults.standard.value(forKey: FIRST_INSTALL) == nil {
//        UserDefaults.standard.set(true, forKey: FIRST_INSTALL)
//        let settings = NetworkManager.dataBaseRef.settings
//        settings.areTimestampsInSnapshotsEnabled = true
//        NetworkManager.dataBaseRef.settings = settings
//        }
        setupView()

    }

    func setupView() {
        postButtonOutlet.layer.cornerRadius = 5
        postText.layer.cornerRadius = 5
        postText.text = "My random thought..."
        postText.textColor = UIColor.lightGray
        postText.delegate = self
    }

    @IBAction func catogerySegmentClicked(_ sender: Any) {
        categorySelected = catogerySegment.titleForSegment(at: catogerySegment.selectedSegmentIndex)!
        
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        Firestore.firestore().collection(PostConstants.postCollectionRef).addDocument(data: getPostDictionay()) { (error) in
            guard let error = error else {
                self.navigationController?.popViewController(animated: true)
                return
            }
            debugPrint("error in add post: \(error.localizedDescription)")
        }
    }

    // method for start editing textview
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = userNameText.textColor
    }

    func getPostDictionay() -> [String:Any] {
        let postDictioray: [String:Any] = [PostConstants.category:categorySelected,
                                           PostConstants.numOfComments:0,
                                           PostConstants.numOfLikes:0,
                                           PostConstants.postText:postText.text,
                                           PostConstants.userName:userNameText.text,
                                           PostConstants.timeStamp:FieldValue.serverTimestamp()]
        return postDictioray
    }
    
}
