//
//  ResultView.swift
//  SampleMidterm
//
//  Created by Arshdeep Singh on 2023-10-17.
//

import SwiftUI



struct ResultView: View {
    
    @EnvironmentObject var dbHelper: DBHelper
    

    var body: some View {
        
        NavigationStack{
            Text("Results")
            VStack{
                List{
                    ForEach(dbHelper.resultList, id: \.self){
                        data in

                        Section{
                            VStack{
                                Text("Name: \(data.username ?? "NA")")
                                Text("Result: \(data.result ?? "NA")")
                                Text("Correct Number: \(data.correctNumber)")
                                Text("Attempts: \(data.guessNumber)")
                            }
                        }
                    }
                }
            }
            .onAppear(){
                self.dbHelper.retreiveAllScores()
            }
        }
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
