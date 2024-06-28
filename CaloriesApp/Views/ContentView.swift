//
//  ContentView.swift
//  CaloriesApp
//
//  Created by Lalu Iman Abdullah on 28/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showingAddView = false
    
    static let color0 = Color(red: 55/255, green: 170/255, blue: 224/255);
          
    static let color1 = Color(red: 11/255, green: 69/255, blue: 215/255);
           

    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: gradient,
                            startPoint: .init(x: 0.36, y: 0.02),
                            endPoint: .init(x: 0.64, y: 0.98)
                          ))
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack(alignment: .center){
                        HStack {
                            Text("\(Int(totalCaloriesToday())) KCal (Today)")
                                .font(.title).bold()
                                .foregroundStyle(.white)
                            ZStack {
                                Image(systemName: "flame")
                                    .font(.title).bold()
                                .foregroundColor(.orange)
                                Image(systemName: "flame.fill")
                                    .font(.title).bold()
                                .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                    .frame(width: 320, height: 150)
                }
                .padding()
                List{
                    ForEach(food){ food in
                        NavigationLink(destination: EditFoodView(food: food)){
                            HStack{
                                VStack(alignment: .leading, spacing: 6){
                                    Text(food.name!)
                                        .foregroundStyle(.cyan)
                                        .bold()
                                    HStack {
                                        Text("\(Int(food.calories))")
                                            .fontWeight(.semibold)
                                        .padding(.leading)
                                        Text("calories")
                                            .foregroundStyle(.green)
                                    }
                                    
                                }
                                Spacer()
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingAddView = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.blue)
                            .font(.title2).bold()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("CaloriesTracker")
                        .font(.title).bold()
                        .foregroundStyle(.blue)
                    //EditButton()
                }
            }
            .sheet(isPresented: $showingAddView, content: {
                AddFoodView()
            })
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map{food[$0]}.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalCaloriesToday() -> Double{
        var caloriesToday: Double = 0
        for item in food{
            if Calendar.current.isDateInToday(item.date!){
                caloriesToday += item.calories
            }
        }
        return caloriesToday
    }
}

#Preview {
    ContentView()
}
