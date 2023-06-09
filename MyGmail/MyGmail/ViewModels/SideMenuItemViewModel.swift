/* * Copyright 2023 Simon Zhang. All rights reserved. */

import SwiftUI

class SideMenuItemViewModel: ObservableObject {
    @Published private var model = SideMenuItems()
    @ObservedObject var filterService: FilterService

    init(model: SideMenuItems = SideMenuItems(), filterService: FilterService) {
        self.model = model
        self.filterService = filterService
    }

    var cells: [CellItem] {
        model.cells
    }

    func select(_ cell: CellItem) {
        model.select(cell)

        switch menuButton(rawValue: cell.title) {
        case .allInboxes:
            filterService.currentFilter = { !$0.isSent && !$0.isArchived && !$0.isSpam && !$0.isTrash }
        case .primary:
            filterService.currentFilter = { $0.isPrimary && !$0.isArchived }
        case .social:
            filterService.currentFilter = { $0.isSocial && !$0.isArchived }
        case .promotions:
            filterService.currentFilter = { $0.isPromotions && !$0.isArchived }
        case .starred:
            filterService.currentFilter = { $0.isStarred && !$0.isArchived }
        case .snoozed:
            filterService.currentFilter = { $0.isSnoozed && !$0.isArchived}
        case .important:
            filterService.currentFilter = { $0.isImportant && !$0.isArchived}
        case .sent:
            filterService.currentFilter = { $0.isSent }
        case .scheduled:
            filterService.currentFilter = { $0.isScheduled && !$0.isArchived }
        case .drafts:
            filterService.currentFilter = { $0.isDraft }
        case .spam:
            filterService.currentFilter = { $0.isSpam }
        case .allMail:
            filterService.currentFilter = { !$0.isArchived && !$0.isSent }
        case .trash:
            filterService.currentFilter = { $0.isTrash }
        case .archived:
            filterService.currentFilter = { $0.isArchived }
        default:
            filterService.currentFilter = { !$0.isSent && !$0.isArchived && !$0.isSpam && !$0.isTrash }
        }
    }
}

enum menuButton: String {
    case allInboxes = "All Inboxes"
    case primary = "Primary"
    case social = "Social"
    case promotions = "Promotions"
    case starred = "Starred"
    case snoozed = "Snoozed"
    case important = "Important"
    case sent = "Sent"
    case scheduled = "Scheduled"
    case drafts = "Drafts"
    case allMail = "All mail"
    case spam = "Spam"
    case trash = "Trash"
    case archived = "Archive"
    case createNew = "Create New"
    case settings = "Settings"
    case feedback = "Send feedback"
    case help = "Help"
}
