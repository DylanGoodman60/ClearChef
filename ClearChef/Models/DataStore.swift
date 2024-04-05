//
//  RecipeStore.swift
//  ClearChef
//
//  Created by Taylor Newman on 2024-04-03.
//

import SwiftUI
import CoreData

class DataStore: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        .init(
              id: UUID(uuidString: "5f6e22a4-c4b8-485c-9b15-b1fc8ab4641b")!,
              title: "Pad Thai",
              description: "Easy Pad Thai Recipe",
              category: "Breakfast",
              cookTime: ["1 h", "10 m"],
              ingredients: [
                Ingredient(id: UUID(uuidString: "B38EDF6D-BA37-46F3-A5E3-8DEA4AB7B33B")!, title: "1 1/2 tbsp tamarind puree"),
                Ingredient(id: UUID(uuidString: "41DA7DF2-789A-43E2-9137-138057ADEE83")!, title: "3 tbsp (packed) brown sugar"),
                Ingredient(id: UUID(uuidString: "7F27D105-7A9F-4B4E-9AA3-EA11FCDEC75B")!, title: "2 tbsp fish sauce"),
                Ingredient(id: UUID(uuidString: "F62866C3-8C10-4F99-B049-D394E5DDDEA6")!, title: "1 1/2 tbsp oyster sauce"),
                Ingredient(id: UUID(uuidString: "072F022C-7130-4547-8C71-0E8DE04219E0")!, title: "Sauce"),
                Ingredient(id: UUID(uuidString: "611E35C6-6CEE-48A0-B18D-C75886C90DC6")!, title: "125 g Chang’s Pad Thai dried rice sticks"),
                Ingredient(id: UUID(uuidString: "31603C39-5193-4ED4-9234-CDDA9048FD2B")!, title: "2 – 3 tbsp vegetable or canola oil"),
                Ingredient(id: UUID(uuidString: "DDE2556E-7D28-47D4-B35D-F6E8DCDF52A8")!, title: "1/2 onion"),
                Ingredient(id: UUID(uuidString: "73734751-D398-462A-BA8E-A23658528FA5")!, title: "2 garlic cloves"),
                Ingredient(id: UUID(uuidString: "2D445F94-6B14-4904-98DB-4E26CB88A1E1")!, title: "150 g chicken breast (or thigh)"),
                Ingredient(id: UUID(uuidString: "0121D624-250A-4ED0-AA35-FA8C5408954B")!, title: "2 eggs"),
                Ingredient(id: UUID(uuidString: "B88F7AB2-607D-49EC-9EAF-0C5FEF42AD5B")!, title: "1 1/2 cups of beansprouts"),
                Ingredient(id: UUID(uuidString: "382ED3F3-3F98-4EA3-A1AB-6AC98FA8D603")!, title: "1/2 cup firm tofu, cut into 3cm cubes"),
                Ingredient(id: UUID(uuidString: "F76C0606-2682-42E5-98CC-788ACEC4F685")!, title: "1/4 cup garlic chives , cut into 3cm pieces"),
                Ingredient(id: UUID(uuidString: "4CAB51AF-4908-42B9-9720-2DAAE2FB333D")!, title: "1/4 cup finely chopped peanuts"),
                Ingredient(id: UUID(uuidString: "A72B14C6-7745-4BC7-8D7C-9700D2DE0D3B")!, title: "Lime wedges"),
                Ingredient(id: UUID(uuidString: "14B86744-FACB-49C3-9C71-4A6E722BAB1B")!, title: "Ground chilli or cayenne pepper"),
              ],
              directions: [
                Direction(id: UUID(uuidString: "F317B9A0-2C26-445F-AF82-2550D0779A75")!, title: "Place noodles in a large bowl, pour over plenty of boiling water. Soak for 5 minutes, then drain in a colander and quickly rinse under cold water. Don’t leave them sitting around for more than 5 – 10 minutes."),
                Direction(id: UUID(uuidString: "6C3C5127-29F0-4A49-AB43-D5996E6D0163")!, title: "Mix Sauce in small bowl."),
                Direction(id: UUID(uuidString: "AE825E27-D2D0-4B62-9833-972DD67EA7C4")!, title: "Heat 2 tbsp oil in a large non stick pan (or well seasoned skillet) over high heat. Add garlic and onion, cook for 30 seconds."),
                Direction(id: UUID(uuidString: "F30BB520-9E37-4010-AB06-5A138A6C49D8")!, title: "Add chicken and cook for 1 1/2 minutes until mostly cooked through."),
                Direction(id: UUID(uuidString: "9CE0BBA6-D15B-455B-B60D-6E09D6292B56")!, title: "Push chicken to one side of the pan, pour egg in on the other side. Scramble using the wooden spoon (add touch of extra oil if pan is too dry), then mix into chicken."),
                Direction(id: UUID(uuidString: "08180942-A6BA-4F93-A499-51DBC3A3CCF5")!, title: "Add bean sprouts, tofu, noodles then Sauce."),
                Direction(id: UUID(uuidString: "8D9E2700-981C-4C9C-9519-03B23F7C679C")!, title: "Toss gently for about 1 1/2 minutes until Sauce is absorbed by the noodles."),
                Direction(id: UUID(uuidString: "3430939E-A250-4819-92E3-2C11DC26D9C1")!, title: "Add garlic chives and half the peanuts. Toss through quickly then remove from heat."),
                Direction(id: UUID(uuidString: "97D62BB4-6DBB-4E86-BB98-1B04CB1DE6E3")!, title: "Serve immediately, sprinkled with remaining peanuts and lime wedges on the side, with a sprinkle of chilli and a handful of extra beansprouts on the side if desired (this is the Thai way!). Squeeze over lime juice to taste before eating."),
              ],
              directionsMap: [
                UUID(uuidString: "F317B9A0-2C26-445F-AF82-2550D0779A75")! : [UUID(uuidString: "611E35C6-6CEE-48A0-B18D-C75886C90DC6")!],
                UUID(uuidString: "6C3C5127-29F0-4A49-AB43-D5996E6D0163")! : [UUID(uuidString: "B38EDF6D-BA37-46F3-A5E3-8DEA4AB7B33B")!, UUID(uuidString: "F62866C3-8C10-4F99-B049-D394E5DDDEA6")!, UUID(uuidString: "41DA7DF2-789A-43E2-9137-138057ADEE83")!, UUID(uuidString: "7F27D105-7A9F-4B4E-9AA3-EA11FCDEC75B")!],
                UUID(uuidString: "AE825E27-D2D0-4B62-9833-972DD67EA7C4")! : [UUID(uuidString: "31603C39-5193-4ED4-9234-CDDA9048FD2B")!, UUID(uuidString: "DDE2556E-7D28-47D4-B35D-F6E8DCDF52A8")!, UUID(uuidString: "73734751-D398-462A-BA8E-A23658528FA5")!],
                UUID(uuidString: "F30BB520-9E37-4010-AB06-5A138A6C49D8")! : [UUID(uuidString: "2D445F94-6B14-4904-98DB-4E26CB88A1E1")!],
                UUID(uuidString: "9CE0BBA6-D15B-455B-B60D-6E09D6292B56")! : [UUID(uuidString: "0121D624-250A-4ED0-AA35-FA8C5408954B")!],
                UUID(uuidString: "08180942-A6BA-4F93-A499-51DBC3A3CCF5")! : [UUID(uuidString: "B88F7AB2-607D-49EC-9EAF-0C5FEF42AD5B")!, UUID(uuidString: "382ED3F3-3F98-4EA3-A1AB-6AC98FA8D603")!, UUID(uuidString: "611E35C6-6CEE-48A0-B18D-C75886C90DC6")!, UUID(uuidString: "072F022C-7130-4547-8C71-0E8DE04219E0")!],
                UUID(uuidString: "8D9E2700-981C-4C9C-9519-03B23F7C679C")! : [UUID(uuidString: "072F022C-7130-4547-8C71-0E8DE04219E0")!, UUID(uuidString: "611E35C6-6CEE-48A0-B18D-C75886C90DC6")!],
                UUID(uuidString: "3430939E-A250-4819-92E3-2C11DC26D9C1")! : [UUID(uuidString: "F76C0606-2682-42E5-98CC-788ACEC4F685")!, UUID(uuidString: "4CAB51AF-4908-42B9-9720-2DAAE2FB333D")!],
                UUID(uuidString: "97D62BB4-6DBB-4E86-BB98-1B04CB1DE6E3")! : [UUID(uuidString: "4CAB51AF-4908-42B9-9720-2DAAE2FB333D")!, UUID(uuidString: "A72B14C6-7745-4BC7-8D7C-9700D2DE0D3B")!, UUID(uuidString: "14B86744-FACB-49C3-9C71-4A6E722BAB1B")!],
              ],
              image: Image("padThai")),
        .init(
              title: "OatMeal",
              description: "Easy Oatmeal Recipe",
              category: "",
              prepTime: ["0 h", "5 m"],
              cookTime: ["0 h", "2 m"],
              ingredients: [
                Ingredient(id: UUID(uuidString: "362f3c71-8e04-4ee7-9218-cf88793bb0bb")!, title: "1/2 cup rolled oats"),
                Ingredient(id: UUID(uuidString: "fdebd72c-d8cf-4524-9bbb-035c4bec76b4")!, title: "1/2 tbsp sugar"),
                Ingredient(id: UUID(uuidString: "a3ce2361-1fff-4960-971a-d0b8b14eecf1")!, title: "Blueberries")
              ],
              directions: [
                Direction(id: UUID(uuidString: "90dbd392-9c26-48ab-903e-49a9e9f6c00c")!, title: "Microwave Oats for 1:00 minute"),
                Direction(id: UUID(uuidString: "75be6638-2dcd-4343-9518-62577138470e")!, title: "Add berries and sugar"),
                Direction(id: UUID(uuidString: "9955b4a8-f66f-4036-96b0-73aa9861c597")!, title: "Eat")
              ],
              directionsMap: [
                UUID(uuidString: "90dbd392-9c26-48ab-903e-49a9e9f6c00c")! : [UUID(uuidString: "362f3c71-8e04-4ee7-9218-cf88793bb0bb")!],
                UUID(uuidString: "75be6638-2dcd-4343-9518-62577138470e")! : [UUID(uuidString: "fdebd72c-d8cf-4524-9bbb-035c4bec76b4")!, UUID(uuidString: "a3ce2361-1fff-4960-971a-d0b8b14eecf1")!]
              ],
              image: Image("oatmeal")),
    ]
    
    @Published var categories: [String] = [
        "Breakfast",
        "Lunch",
        "Dessert",
        "Snack",
        "Side Dish"
    ]
    
    func deleteRecipe(id: UUID) -> Void {
        recipes.removeAll { recipe in
            recipe.id == id
        }
    }
    
    func deleteCategory(name: String) -> Void {
        categories.removeAll { category in
            category == name
        }
    }
    
/// We can use this later to get recipes from storage
//    init(isDarkMode: Bool) {
//        self._recipes = Published(initialValue: functionCall())
//    }
}
