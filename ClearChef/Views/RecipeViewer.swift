import SwiftUI

struct TimerView: View {
    @State var timerTime = ["0 m", "10 s"]
    let data: [(String, [String])] = [
        ("One", Array(0...60).map { "\($0) m" }),
        ("Two", Array(0...60).map { "\($0) s" }),
    ]
    @State var timerIsActive = false
    @State private var timeRemaining = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func getTimeInSecondsFromTimerTime() -> Int{
        var total = 0
        let splitStringMinute = timerTime[0].split(separator: " ")
        let splitStringSecond = timerTime[1].split(separator: " ")

        if let intMinute = Int(splitStringMinute[0]) {
            total += (intMinute*60)
        }
        
        if let intSecond = Int(splitStringSecond[0]) {
            total += intSecond
        }
        
        return total
    }
    
    func stopTimer() {
        timerIsActive = false
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        timerIsActive = true
        timeRemaining = getTimeInSecondsFromTimerTime()
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func getTimeString() -> Text {
        let minuteString = timeRemaining / 60 != 0 ? String(timeRemaining/60) + " Minutes " : ""
        let secondString = String(timeRemaining%60)
        let string = minuteString + secondString + " Seconds"
        return Text(string)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                if(timerIsActive){
                    self.stopTimer()
                } else {
                    self.startTimer()
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).foregroundStyle(timerIsActive ? .red : .blue)
                    HStack {
                        if(!timerIsActive){
                            Text("Start")
                            Image(systemName: "play.square")
                        } else {
                            Text("Stop")
                            Image(systemName: "stop.fill")
                        }

                    }.foregroundStyle(.white)
                }
            })
            .frame(width: UIScreen.main.bounds.width/2 - 50, height: UIScreen.main.bounds.height - 200)
            Spacer()
            if (timerIsActive){
                getTimeString().font(.title).frame(width: UIScreen.main.bounds.width/2 - 60, height: UIScreen.main.bounds.height - 200)
            } else {
                MultiPicker(data: data, selection: $timerTime).frame(width: UIScreen.main.bounds.width/2 - 60, height: UIScreen.main.bounds.height - 200)
            }
        }.padding([.leading, .trailing], 150).onReceive(timer, perform: { time in
            guard timerIsActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            
            if timeRemaining == 0 {
                stopTimer()
            }
        })
    }
}

struct DirectionTab: View {
    let direction: Direction
    let ingredients: [Ingredient]
    let directionCount: Int
    @Binding var selectedView: Int
    @Binding var selectedTab: Int
    @EnvironmentObject private var settings: SettingsStore
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        let selectedFont = Font(UIFont(name: settings.fontFamily, size: settings.fontSize) ?? UIFont.systemFont(ofSize: settings.fontSize))
        GeometryReader { proxy in
            TabView(selection: $selectedView) {
                        TimerView().rotationEffect(.degrees(-90)) // Rotate content
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height
                            ).tag(0)

                        
                ZStack {
                    Color.white.frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
                    Text(direction.title).font(selectedFont).rotationEffect(.degrees(-90)) // Rotate content
                        .frame(
                            width: proxy.size.width-120,
                            height: proxy.size.height
                        )
                        .foregroundColor((settings.fontColor == .white) ? (colorScheme == .dark ? .white : .black) : settings.fontColor)
                }.tag(1).onTapGesture(coordinateSpace: .global) { location in
                                if(location.x < UIScreen.main.bounds.width/2 && selectedTab > 0){
                                    selectedTab -= 1
                                } else if (location.x > UIScreen.main.bounds.width/2 && selectedTab < directionCount-1) {
                                    selectedTab += 1
                                }
                            }
               

                    if (!ingredients.isEmpty){
                        VStack{
                            ForEach(ingredients.indices, id: \.self) {ingredient_index in
                                Text(ingredients[ingredient_index].title).font(.title3)
                            }
                        }.rotationEffect(.degrees(-90)) // Rotate content
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height
                            ).tag(2)
                    }
                    .onChange(of: )
                    }
                    .frame(
                        width: proxy.size.height, // Height & width swap
                        height: proxy.size.width
                    )
                    .rotationEffect(.degrees(90), anchor: .topLeading) // Rotate TabView
                    .offset(x: proxy.size.width) // Offset back into screens bounds
                    .tabViewStyle(
                        PageTabViewStyle(indexDisplayMode: .never)
                    )
        }
    }
}


struct RecipeViewer: View {
    @State private var selectedTab = 0
    @State private var selectedView = 1
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

    var recipe: Recipe
        
    func getRelatedInstructions(direction: Direction) -> [Ingredient]{
        
        let ingredients = recipe.ingredients.filter { Ingredient in
            if let directions = recipe.directionsMap[direction.id] {
                return directions.contains { ingredients_uuid in
                    return Ingredient.id == ingredients_uuid
                }
            }
            return false
        }
        
        return ingredients
    }
    
    var body: some View {
        if (horizontalSizeClass == .compact && verticalSizeClass == .regular){
            Image(systemName: "rectangle.landscape.rotate")
            Text("Please Rotate Phone")
        } else {
            TabView(selection: $selectedTab) {
                ForEach(recipe.directions.indices, id: \.self) { direction_index in
                    DirectionTab(direction: recipe.directions[direction_index], ingredients: getRelatedInstructions(direction: recipe.directions[direction_index]), directionCount: recipe.directions.count, selectedView: $selectedView, selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName: "circle")
                        }
                        .tag(direction_index)
                }
            }.tabViewStyle(.page)

            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)).navigationBarHidden(true)
        }
    }
}

struct RecipeViewer_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight).environmentObject(DataStore())
    }
}
