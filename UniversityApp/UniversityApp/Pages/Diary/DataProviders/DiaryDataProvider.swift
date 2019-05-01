
import Foundation
import FirebaseFirestore

protocol DiaryDataProviderDelegate : class{
    func dataLoaded()
}


class DiaryDataProvider {
    var models : [SubjectModel] = [SubjectModel]()
    
    weak var delegate : DiaryDataProviderDelegate?
    func getData(weekDay: String){
        self.models = []
        var models : [SubjectModel] = [SubjectModel]()
        Firestore.firestore().collection("Diary").document(UsersModel.userModel.Institute).collection(UsersModel.userModel.Facultet).document(UsersModel.userModel.Group).collection(weekDay).getDocuments { (snapShot, error) in
            if error != nil {
                print("Что-то пошло не так ... \n \(error.debugDescription)")
            } else {
                if snapShot?.documents != nil {
                    for document in (snapShot?.documents)!{
                        if document.data()["Group"] as! String == UsersModel.userModel.SubGroup || document.data()["Group"] as! String == "All"{
                        let model = SubjectModel()
                        model.name = document.data()["Name"] as! String
                        model.room = document.data()["Room"] as! String
                        model.teacher = document.data()["Teacher"] as! String
                        model.time = document.data()["Time"] as! String
                        models.append(model)
                        }
                    }
                }
                self.models = models
                self.delegate?.dataLoaded()
            }
        }
    }
}
