//
//  DBHelper.swift
//  SampleMidterm
//
//  Created by Arshdeep Singh on 2023-10-17.
//

import Foundation
import CoreData

class DBHelper: ObservableObject{
    
    @Published var resultList = [GameResult]()
    
    private static var shared: DBHelper?
    private let moc: NSManagedObjectContext
    
    private let ENTITY_NAME = "GameResult"
    private let ATTRIBUTE_CNO = "correctNumber"
    private let ATTRIBUTE_GUESS = "guessNumber"
    private let ATTRIBUTE_RESULT = "result"
    private let ATTRIBUTE_NAME = "username"
    
    static func getInstance() -> DBHelper{
        if(self.shared == nil){
            shared = DBHelper(context: PersistenceController.preview.container.viewContext)
        }
        
        return self.shared!
    }
    
    private init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertResult(c_num: Int, g_num: Int, result: String, u_name: String){
        
        do {
            
            let newRec = NSEntityDescription.insertNewObject(forEntityName: self.ENTITY_NAME, into: self.moc) as! GameResult
            
            
            newRec.id = UUID()
            newRec.correctNumber = Int64(c_num)
            newRec.username = u_name
            newRec.result = result
            newRec.guessNumber = Int64(g_num)
            
            
            
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Operation is successfull: ")
            }
            
        } catch let err as NSError{
                    print(#function,"Unable to insert data: \(err)")

        }
            
            
    }
    
   func retreiveAllScores(){
        let fetchRequest = NSFetchRequest<GameResult>(entityName: self.ENTITY_NAME)

        do{
            let output = try self.moc.fetch(fetchRequest)

            if(output.count > 0){

                for rest in output{
                    print(#function, "Result: \(rest.username) - \(rest.correctNumber)")
                }

                self.resultList = output
            }else{
                print(#function,"There are no records to display")
            }

        }catch let err as NSError{
            print(#function,"Unable to retreive records: \(err)")
        }
    }
}
