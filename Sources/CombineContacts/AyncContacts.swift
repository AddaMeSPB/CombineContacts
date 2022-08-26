import Contacts
import Foundation

extension CombineContacts {
    /// Requests access to the user's contacts.
    ///
    /// - Parameter entityType: Set to CNEntityTypeContacts.
    /// - Returns: Set granted to true if the user allows access and error is nil.
    public func requestAccessAsync(for entityType: CNEntityType) async throws -> Bool {
        do {
            return try await self.contactStore.requestAccess(for: entityType)
        } catch {
            throw ContactError.entityTypeError
        }
    }
    
    // MARK: - Fetching Unified Contacts
    
    /// Fetches all unified contacts matching the specified predicate.
    ///
    /// - Parameters:
    ///   - predicate: The predicate to match against.
    ///   - keys: The properties to fetch in the returned CNContact objects. You should fetch only the properties that you plan to use. Note that you can combine contact keys and contact key descriptors.
    /// - Returns: An array of CNContact objects matching the predicate.
    
    public func unifiedContactAsync(withIdentifier identifier: String, keysToFetch keys: [CNKeyDescriptor]) async throws -> CNContact {
        
        do {
            return try self.contactStore.unifiedContact(withIdentifier: identifier, keysToFetch: keys)
        } catch {
            throw ContactError.identifierAndKeysToFetchError
        }
    }
    
    /// Fetches a unified contact for the specified contact identifier.
    ///
    /// - Parameters:
    ///   - identifier: The identifier of the contact to fetch.
    ///   - keys:     The properties to fetch in the returned CNContact object.
    /// - Returns: A unified contact matching or linked to the identifier.
    public func unifiedContactsAsync(matching predicate: NSPredicate, keysToFetch keys: [CNKeyDescriptor] ) async throws -> [CNContact] {
        do {
            return try self.contactStore.unifiedContacts(matching: predicate, keysToFetch: keys)
        } catch {
            throw ContactError.containersMatchingPredicateError
        }
    }
    
    // MARK: - Fetching and Saving
    
    /// Fetches all groups matching the specified predicate.
    ///
    /// - Parameter predicate: The predicate to use to fetch the matching groups. Set predicate to nil to match all groups.
    /// - Returns: An array of CNGroup objects that match the predicate.
    public func groupsAsync(matching predicate: NSPredicate?) async throws -> [CNGroup] {
        do {
            return try self.contactStore.groups(matching: predicate)
        } catch {
            throw ContactError.groupsMatchingPredicateError
        }
    }
    
    /// Fetches all containers matching the specified predicate.
    ///
    /// - Parameter predicate: The predicate to use to fetch matching containers. Set this property to nil to match all containers.
    /// - Returns: An array of CNContainer objects that match the predicate.
    public func containersAsync(matching predicate: NSPredicate?) async throws -> [CNContainer] {
        do {
            return try self.contactStore.containers(matching: predicate)
        } catch  {
            throw ContactError.containersMatchingPredicateError
        }
    }
    
    /// Returns a Boolean value that indicates whether the enumeration of all contacts matching a contact fetch request executed successfully.
    ///
    /// - Parameter fetchRequest: The contact fetch request that specifies the search criteria.
    /// - Returns: true if enumeration of all contacts matching a contact fetch request executes successfully; otherwise, false
//    public func enumerateContactsAsync(with fetchRequest: CNContactFetchRequest) async throws -> (CNContact, UnsafeMutablePointer<ObjCBool>) {
//        do {
//
//           try self.contactStore.enumerateContacts(with: fetchRequest, usingBlock: { (contact, pointer) in
//               let res = (contact, pointer)
//               return res
//           })
//
//
//        } catch {
//            throw ContactError.init(description: "EnumerateContacts error:", reason: error)
//        }
//    }
    
#if os(iOS) || os(OSX)
    
    /// Executes a save request and returns success or failure.
    ///
    /// - Parameter saveRequest: The save request to execute.
    /// - Returns: true if the save request executes successfully; otherwise, false.
    public func executeAsync(_ saveRequest: CNSaveRequest) async throws -> () {
        do {
            return try self.contactStore.execute(saveRequest)
        } catch {
            throw ContactError.init(description: "CNSaveRequest \(error)", reason: error)
        }
    }
    
#endif
    
}
