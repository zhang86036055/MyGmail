//
//  InboxMailsViewModel.swift
//  MyGmail
//
//  Created by Shuai Zhang on 5/8/23.
//

import Foundation

class InboxMailsViewModel: ObservableObject {
    typealias Mail = InboxMails.Mail

    // MARK: Faked data

    private static let preview: [InboxMails.Mail] = [
        Mail(
            profilePicture: "simon",
            sender: "Simon Zhang",
            time: "11:24 AM",
            subject: "*README: Simon Resume *",
            content: """
            3+ years of experience full stack software developer with a versatile skillset. Developed products with 2 billion+ daily active users, proficient in IOS and Web development with Swift , Objective-C, Java and Javascript. Experienced in producing complex projects with programming, designing, management skills. A committed team player who consistently delivers results.

            WORK EXPERIENCE
            Whatsapp, Meta
            Whatsapp Communities, Software Engineer IC4 MountainView,CA | July2022-current
            Worked as production software engineer on WhatsApp 2023 flagship product: WA Communities. Led the creation of multiple key features that catered to over 2 billion+ daily active users.
            Initiated the development process by drafting prototype features from scratch, including UI designs and specification documents. Implemented demos into production and conducted A/B testing to prove the effectiveness of the improvements. Presented the results to team managers to advance the features to reality.
            Responsible for managing several categories on a daily basis, including UI tests, end-to-end(e2e) tests, internationalization(i18n) and accessibility(a11y) bugs, code refactoring and migration for Better Engineering. Served on-call for Severity-One issues.
            Collaborated with external teams to align work on various factors, such as Server Queries, Logging, AB-properties, UX workflow, and other related items.
            Released features: "Community Creation Flow", "Subgroup Manager", "Community Navigation Menu", "Orphaned Participants Cleaner", "Announcement Group Improvement", "Community Introduction Views(NUX)" and 3 more.(by 03/29/23)

            ...
            """,
            isUnread: false, 
            isPrimary: true,
            isStarred: true,
            isImportant: true
        ),
        Mail(
            profilePicture: "cecillia",
            sender: "Cecilia D'Costa",
            time: "10:15 AM",
            subject: "Re: Google Team Match Update",
            content: """
            Thanks, Simon. I have your call scheduled for Wednesday. Doc is updated with the details. Please be sure to take some time to review the Team Match Call Prep Resource
            and specifically practice/prep for the points listed below. Please let me know if you have any questions and let me know how the call goes once completed. 
            """,
            isUnread: false, 
            isPrimary: true,
            isStarred: true,
            isImportant: true
        ),
        Mail(
            profilePicture: "person3",
            sender: "Jessica Lu",
            time: "06:11 AM",
            subject: "Good luck on your interview",
            content: """
            Good luck baby, you are my best bae!!! Love you (heart)
            """,
            isUnread: false, 
            isPrimary: true,
            isStarred: true
        ),
        Mail(
            profilePicture: nil,
            sender: "SPAM",
            time: "02:48 AM",
            subject: "from unknown sender",
            content: """
            put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,
            """,
            isSpam: true
        ),
        Mail(
            profilePicture: nil,
            sender: "Google",
            time: "May 04",
            subject: "Google Team Match Update",
            content: """
            Hi Simon Zhang,Thanks for your interest in a role at Google! We received your application and will be in touch soon about next steps.
            Thanks,
            Google Recruiting
            """,
            isTrash: true
        ),
        Mail(
            profilePicture: "person5",
            sender: "John Smith",
            time: "May 02",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isPrimary: true,
            isSocial: true
        ),
        Mail(
            profilePicture: "person6",
            sender: "John Smith2",
            time: "April 28",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isPrimary: true,
            isSocial: true
        ),
        Mail(
            profilePicture: "person7",
            sender: "John Smith3",
            time: "April 26",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isUnread: true,
            isSocial: true
        ),
        Mail(
            profilePicture: "person8",
            sender: "John Smith4",
            time: "April 24",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isUnread: true,
            isSpam: true
        ),

        Mail(
            profilePicture: nil,
            sender: "Tom Kitty",
            time: "11:24 AM",
            subject: "First Email from Simon",
            content: """
            Hi there, I’m emailing you today to let you know we have created a new project called myGmail. In this article, you’ll learn how to do it by yourself with SwiftUI
            If you know anybody else who’ll find this useful, please forward the email to them.Let us know if you face any problems accessing the project 
            by replying to this email. We’ll get back to you ASAP and ensure you gain access to it immediately.
            Thank you
            """,
            isPrimary: true,
            isPromotions: true

        ),
        Mail(
            profilePicture: "simon",
            sender: "You",
            time: "10:15 AM",
            subject: "Re: Google Team Match Update",
            content: """
            Thanks, Simon. I have your call scheduled for Wednesday. Doc is updated with the details. Please be sure to take some time to review the Team Match Call Prep Resource
            and specifically practice/prep for the points listed below. Please let me know if you have any questions and let me know how the call goes once completed. 
            """,
            isUnread: false,
            isSent: true
        ),
        Mail(
            profilePicture: "simon",
            sender: "You",
            time: "06:11 AM",
            subject: "Re:Good luck on your interview",
            content: """
            Good luck baby, you are my best bae!!! Love you (heart)
            """,
            isUnread: false,
            isSent: true
        ),
        Mail(
            profilePicture: nil,
            sender: "Annie Lee",
            time: "02:48 AM",
            subject: "from unknown sender",
            content: """
            put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,put me into spam,
            """,
            isSpam: true
        ),
        Mail(
            profilePicture: "person7",
            sender: "Cara Sue",
            time: "May 04",
            subject: "Google Team Match Update",
            content: """
            Hi Simon Zhang,Thanks for your interest in a role at Google! We received your application and will be in touch soon about next steps.
            Thanks,
            Google Recruiting
            """,
            isUnread: false,
            isDraft: true
        ),
        Mail(
            profilePicture: "person10",
            sender: "Tim Cook",
            time: "May 02",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isPrimary: true
        ),
        Mail(
            profilePicture: nil,
            sender: "SPAM2",
            time: "April 28",
            subject: "Test Test",
            content: """
            To have this test, you swallow a string with a weighted gelatin capsule on the end. The string is pulled out 4 hours later. Any bile, blood, or mucus attached to the string is examined under the microscope. This is done to look for cells and parasites or parasite eggs.
            """,
            isSpam: true
        ),
    ]

    @Published private var model = createInboxMails()

    private static func createInboxMails() -> InboxMails {
        return InboxMails(preview)
    }

    var mails: [Mail] {
        return model.mails
    }

    var unreads: Int {
        var count = 0
        for mail in model.mails {
            if mail.isUnread {
                count += 1
            }
        }
        return count
    }

    func getUnreads(of catagory: String) -> Int {
        var count = 0

        var isUnderCatagory = false
        for mail in model.mails {
            switch menuButton(rawValue: catagory) {
            case .allInboxes:
                isUnderCatagory = !mail.isTrash && !mail.isSpam && !mail.isTrash && !mail.isArchived
            case .primary:
                isUnderCatagory = mail.isPrimary
            case .social:
                isUnderCatagory = mail.isSocial
            case .promotions:
                isUnderCatagory = mail.isPromotions
            case .starred:
                isUnderCatagory = mail.isStarred
            case .snoozed:
                isUnderCatagory = mail.isSnoozed
            case .important:
                isUnderCatagory = mail.isImportant
            case .sent:
                isUnderCatagory = mail.isSent
            case .scheduled:
                isUnderCatagory = mail.isScheduled
            case .drafts:
                isUnderCatagory = mail.isDraft
            case .spam:
                isUnderCatagory = mail.isSpam
            case .allMail:
                isUnderCatagory = true
            case .trash:
                isUnderCatagory = mail.isTrash
            case .archived:
                isUnderCatagory = mail.isTrash
            default:
                isUnderCatagory = false
            }

            if isUnderCatagory && mail.isUnread {
                count += 1
            }
        }

        return count
    }

    init(model: InboxMails = createInboxMails()) {
        self.model = model
    }

    func star(_ mail: Mail) {
        model.star(mail)
    }

    func important(_ mail: Mail) {
        model.important(mail)
    }

    func archive(_ mail: Mail) {
        model.archive(mail)
    }

    func read(_ mail: Mail) {
        model.read(mail)
    }
}
