//
//  FirebaseError.swift
//  TV2-projekt
//
//  Created by Anders Biller Due on 09/04/2021.
//

import Foundation

// MARK: - Firstore errors
enum FireStoreError: Error {
    case noAuthDataResult
    case noCurrentUser
    case noDocumentSnapshot
    case noSnapshotData
    case noUser
}

extension FireStoreError: LocalizedError {
    // This will provide me with a specific localized description for the FireStoreError
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No Current User", comment: "")
        case .noDocumentSnapshot:
            return NSLocalizedString("No Document Snapshot", comment: "")
        case .noSnapshotData:
            return NSLocalizedString("No Snapshot Data", comment: "")
        case .noUser:
            return NSLocalizedString("No User", comment: "")
        }
    }
}

// MARK: - Signin in with email errors
enum EmailAuthError: Error {
    case incorrectPassword
    case invalidEmail
    case accoundDoesNotExist
    case unknownError
    case couldNotCreate
    case extraDataNotCreated
}

extension EmailAuthError: LocalizedError {
    // This will provide me with a specific localized description for the EmailAuthError
    var errorDescription: String? {
        switch self {
        case .incorrectPassword:
            return NSLocalizedString("Incorrect Password for this account", comment: "")
        case .invalidEmail:
             return NSLocalizedString("Not a valid email address.", comment: "")
        case .accoundDoesNotExist:
            return NSLocalizedString("Not a valid email address.  This account does not exist.", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error.  Cannot log in.", comment: "")
        case .couldNotCreate:
            return NSLocalizedString("Could not create user at this time.", comment: "")
        case .extraDataNotCreated:
            return NSLocalizedString("Could not save user's full name.", comment: "")
        }
    }
}
