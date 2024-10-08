//
//  iOSQuestions+SwiftUI.swift
//  iOSInterviewGuide
//
//  Created by Karthik on 08/10/24.
//

import Foundation

/*

 @State is used for local state management within a view
 @Binding allows a child view to mutate a state owned by a parent view
 @ObservedObject which confirms observerable object protcol, enables the view to update on changes
 @EnvironmentObject - similar to observed object but for passing an observable object deep into the view hierarchy
 without manually passing it down
 
 ButtonStyle protocol allows us to customize new button styles that can be reused.
 
 Through what observable objects announce modifications to SwiftUI? - using @Published property wrapper or objectWillChange.send()
 
*/
