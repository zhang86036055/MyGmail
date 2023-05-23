//
//  ResponseParsingTask.swift
//  XCAChatGPT
//
//  Created by Shuai Zhang on 05/23/23.
//

import Foundation
import Markdown

actor ResponseParsingTask {

    func parse(text: String) async -> AttributedOutput {
        let document = Document(parsing: text)
        var markdownParser = MarkdownAttributedStringParser()
        let results = markdownParser.parserResults(from: document)
        return AttributedOutput(string: text, results: results)
    }

}
