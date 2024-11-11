//
//  iOSQuestions+SwiftUI.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 08/10/24.
//

import Foundation
import SwiftUI

/*

 SwiftUI
 - Declarative syntax
 - Live Preview
 - Supports Multiple platform (all apple eco system)
 - Automatic Accessibility support
 - Built in animations and transitions
 
 Why SwiftUI uses struct
 - No shared state - Structs provide value semantics, meaning each instance is a unique value and is passed by value rather than by reference.
 - Immutable by default
 - Thread saftey
 - Performance benifits
 
 @State
 - A local property wrapper that notifies the view to update when changed.
 - @State variables must always have default values and it should be private.
 
 @Binding
 - Used to pass a @State variable to child views. Allows a child view to mutate a state owned by a parent view.
 - Must not be private
 
 @ObservedObject which confirms observerable object protcol, enables the view to update on changes
 
 @EnvironmentObject - similar to observed object but for passing an observable object deep into the view hierarchy
 without manually passing it down.
 - Shared state management, object propagation, and automatic update propogation.
 
 Difference between StateObject and ObservableObject:
 - both used to manage and propogate changes to the view on data changes.
 - @ObservedObject is used to observe an external object, where the view does not own the object but reacts to changes.
 - @StateObject is used when a view owns and manages the lifecycle of an object. SwiftUI will create, initialize, and manage the object’s lifecycle based on the view’s lifecycle.
 
 Views: SwiftUI views are the building blocks of your UI. Each view in SwiftUI is a struct conforming to the View protocol.
 Modifiers - Views are immutable, so you apply modifiers (like .padding(), .font()) to change a view’s properties or layout.
 ViewModifiers - SwiftUI encourages the use of ViewModifier for code reuse. Custom modifiers encapsulate styling or behavior.
 ButtonStyle protocol allows us to customize new button styles that can be reused.
 
 GeometryReader is a container view in SwiftUI that provides information about the geometry of its parent view.
 
 UIViewRepresentable and UIViewControllerRepresentable are protocols in SwiftUI that let you wrap
 UIKit views and view controllers, allowing you to use them within SwiftUI. It uses coordinator pattern to bridge SwiftUI and UIKit.
 - makeUIView and makeUIViewController are used to create instances of the UIKit views or view controllers.
 - updateUIView and updateUIViewController are used to update the view or view controller when SwiftUI's environment or state changes.
 
 Through what observable objects announce modifications to SwiftUI?
 - using @Published property wrapper or objectWillChange.send()
 
 How SwiftUI Evaluated:
 
 https://www.donnywals.com/understanding-how-and-when-swiftui-decides-to-redraw-views/
 - SwiftUI will compare your models regardless of their Equatable conformance in order to determine whether a view needs to have its body re-evaluated.
 And in some cases, your Equatable conformance might be ignored.
 - SwiftUI will always attempt to compare all of its stored properties regardless of whether they're Equatable
 - If your stored properties are Equatable, SwiftUI might decide to rely on your Equatable conformance to determine whether or not your model changed.
 
 - Model confirmed with equatable, and implemented ==. but SwiftUI doesn't care if all the variables are simple old data type.
 if any complex data types were added, then swiftUI starts considering the == implmentation
 
 - Consider ListViewModel, that holds datasource. and each cell in the list view holds a model confirmed to Equatable. when any one item got updated in the datasource,
 ListView will be re-evaluated, and the item got updated will trigger the cell re-evaluation. but here listView re-evaluation doesn't needed. in order to achive that.
 - Keep the DataSource as a class object, and item as well class object (instead of struct). bcoz keeping it as struct where all the problem begins
 
 
 How to debug a SwiftUI view:
 - Using SwiftUI Previews:
 - Print Statements and Debugging Logs
 - Xcode’s View Debugger to inspect the view hierarchy during runtime.
 
 
 Perfromance:
 How do you identify performance issue in SwiftUI app
 - TimeProfiler, CoreAniation and Leaks
 - Execessive State changes - Check for excessive state changes triggering unnecessary view updates.
 - View Hierarchy complexity - Deep or complex view hierarchies can impact performance.
 - Redraws and layout updates - SwiftUI’s declarative nature might trigger unnecessary redraws or layout updates.
 - Reduce View Updates: Use @State, @Binding, or @StateObject sparingly and only when necessary. Leverage EquatableView or id() for preventing unnecessary view updates. 
*/

// Instead of struct, keeping it as class.
class Item: Identifiable, ObservableObject {
    let id = UUID()
    @Published var isActive: Bool = false // *** This will helps trigger the cell updates, rather entire listview re-evaluation.
}

class ListViewDataSource: ObservableObject {
    var items: [Item] = []
}

struct ListCellView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        Text("\(item.id)")
    }
}

struct ExampleListView: View {
    @StateObject var datasource: ListViewDataSource = .init()
    
    var body: some View {
        ForEach(datasource.items) { item in
            ListCellView(item: item)
        }
    }
}
