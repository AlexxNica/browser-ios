/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import Shared

public protocol Identifiable: Equatable {
    var id: Int? { get set }
}

public func ==<T where T: Identifiable>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}

public enum IconType: Int {
    public func isPreferredTo (other: IconType) -> Bool {
        return rank > other.rank
    }

    private var rank: Int {
        switch self {
        case .AppleIconPrecomposed:
            return 5
        case .AppleIcon:
            return 4
        case .Icon:
            return 3
        case .Local:
            return 2
        case .Guess:
            return 1
        case .NoneFound:
            return 0
        }
    }

    case Icon = 0
    case AppleIcon = 1
    case AppleIconPrecomposed = 2
    case Guess = 3
    case Local = 4
    case NoneFound = 5
}

public class Favicon: NSObject, Identifiable, NSCoding {
    public var id: Int? = nil

    public let url: String
    public let date: NSDate
    public var width: Int?
    public var height: Int?
    public let type: IconType

    public init(url: String, date: NSDate = NSDate(), type: IconType) {
        self.url = url
        self.date = date
        self.type = type
    }
    
    required public init?(coder: NSCoder) {
        self.id = Int(coder.decodeInt64ForKey("id"))
        self.url = coder.decodeObjectForKey("url") as? String ?? ""
        self.date = coder.decodeObjectForKey("date") as? NSDate ?? NSDate()
        self.width = Int(coder.decodeInt64ForKey("width"))
        self.height = Int(coder.decodeInt64ForKey("height"))
        self.type = IconType(rawValue: Int(coder.decodeInt64ForKey("type"))) ?? .NoneFound
    }
    
    public func encodeWithCoder(coder: NSCoder) {
        if let id = id {
            coder.encodeInt64(Int64(id), forKey: "id")
        }
        coder.encodeObject(url, forKey: "url")
        coder.encodeObject(date, forKey: "date")
        if let width = width {
            coder.encodeInt64(Int64(width), forKey: "width")
        }
        
        if let height = height {
            coder.encodeInt64(Int64(height), forKey: "height")
        }
        
        coder.encodeInt64(Int64(type.rawValue), forKey: "type")
    }
}

// TODO: Site shouldn't have all of these optional decorators. Include those in the
// cursor results, perhaps as a tuple.
public class Site: Identifiable, Hashable {
    public var id: Int? = nil
    var guid: String? = nil

    public var tileURL: NSURL {
        return NSURL(string: url)?.domainURL() ?? NSURL(string: "about:blank")!
    }

    public let url: String
    public let title: String
     // Sites may have multiple favicons. We'll return the largest.
    public var icon: Favicon?
    public var latestVisit: Visit?
    public let bookmarked: Bool?

    public convenience init(url: String, title: String) {
        self.init(url: url, title: title, bookmarked: false)
    }

    public init(url: String, title: String, bookmarked: Bool?) {
        self.url = url
        self.title = title
        self.bookmarked = bookmarked
    }
    
    // This hash is a bit limited in scope, but contains enough data to make a unique distinction.
    //  If modified, verify usage elsewhere, as places may rely on the hash only including these two elements.
    public var hashValue: Int {
        return 31 &* self.url.hash &+ self.title.hash
    }
}
