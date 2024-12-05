//
//  TodoViewModel.swift
//  Behavior Buddy
//
//  Created by Micah Pressler on 10/24/24.
//
/*
import Foundation
import Amplify

@MainActor
class TodoViewModel: ObservableObject {
    func createTodo() {
        let todo = Todo(
            content: "Build iOS Application",
            //isDone: false
        )
        Task {
            do {
                let result = try await Amplify.API.mutate(request: .create(todo))
                switch result {
                case .success(let todo):
                    print("Successfully created todo: \(todo)")
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            } catch let error as APIError {
                print("Failed to create todo: ", error)
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
}
*/
