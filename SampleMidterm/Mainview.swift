//
//  Mainview.swift
//  SampleMidterm
//
//  Created by Arshdeep Singh on 2023-10-17.
//

import SwiftUI

struct Mainview: View {
    
    @EnvironmentObject var dbHelper: DBHelper
    @Environment(\.dismiss) var dismiss

    
    @State private var name: String = "Arshdeep_Singh"
    @State private var randomNumber = Int.random(in: 1...25)
    @State private var guessedNo = ""
    @State private var attempts = 5
    @State private var message = ""
    @State private var res = "Lost"
    @State private var attemptCout = 0
    
    @State private var showDestination = false

    
    var body: some View {
        
        NavigationStack{
 
            Text("Number Guessing Game")
            
            VStack{
                
          
                    TextField("Enter a number to guess", text: self.$guessedNo)
                    .keyboardType(.numberPad)
                    .padding(100)
                
                Text(message)
                Text("Attempts left: \(attempts)")
                
                    Button{
                        //Validating the number
                        if (Int(guessedNo) ?? 0 > 25 || Int(guessedNo) ?? 0 < 1){
                            message = "Enter a valid number between 1 and 25"
                            //attempts = 5
                        }
                        self.validateNumber()
                    }label:{
                        Text("Validate")
                    }
                    .buttonStyle(.borderedProminent)
             
              
                Button{
                    //Reseting the game
                    self.resetGame()
                } label:{
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)

                    
                Spacer()
                
                NavigationLink{
                    ResultView()
                }label: {
                    Text("Scores")
                }


            }//VStack
            
        }//NavigationStack
        
       // NavigationLink("", destination: ResultView(),isActive: $showDestination)
    }
    
    private func validateNumber(){
        let guess = Int(guessedNo) ?? 0
    
        if (guess > 25 || guess < 1){
            message = "Enter a valid number between 1 and 25"
          
        }
        
        else if guess == randomNumber{
            message = "You got it!"
            res = "Won"
            attempts -= 1
            attemptCout += 1
            
        } else if attempts > 1 {
            message = Int(guessedNo)! < randomNumber ? "Try higher number" : "Try lower number"
            attempts -= 1
            attemptCout += 1
        } else {
            message = "Out Of Attempts. Correct Number is \(randomNumber)"
            attempts = 0
            attemptCout += 1
            res = "Lost"
        }
        
        if (guess == randomNumber || attempts == 0) {
            self.insertResult()
        }
        
        
    }//validateNumber
    
    private func resetGame(){
        randomNumber = Int.random(in: 1...25)
        guessedNo = ""
        attempts = 5
        message = ""
        attemptCout = 0
    }//resetGame
 
    private func insertResult(){
        self.dbHelper.insertResult(c_num: self.randomNumber, g_num: self.attemptCout, result: self.res , u_name: self.name)
    }
}

struct Mainview_Previews: PreviewProvider {
    static var previews: some View {
        Mainview()
    }
}
