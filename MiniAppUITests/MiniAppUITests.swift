//
//  MiniAppUITests.swift
//  MiniAppUITests
//
//  Created by Алексей Гвоздков on 10.09.2024.
//

import XCTest
@testable import MiniApp

final class MiniAppUITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    private func searchCellAndOpenVC(staticTextCell: String) {
        app.collectionViews.cells.staticTexts[staticTextCell].tap()
    }
    
    private func showHideFullScreen() {
        let lineView = app.otherElements["lineView"]
        
        let startCoordinate = lineView.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let fullHeightCoordinate = startCoordinate.withOffset(CGVector(dx: 0, dy: -300))
        let halfHeightCoordinate = startCoordinate.withOffset(CGVector(dx: 0, dy: 300))
        
        startCoordinate.press(forDuration: 1, thenDragTo: fullHeightCoordinate)
        startCoordinate.press(forDuration: 1, thenDragTo: halfHeightCoordinate)
        startCoordinate.press(forDuration: 1, thenDragTo: halfHeightCoordinate)
    }
    
    func testOpenAndClosedWeatherCell() throws {
        searchCellAndOpenVC(staticTextCell: "Погода")
        showHideFullScreen()
    }
    
    func testOpenAndClosedMapCell() throws {
        searchCellAndOpenVC(staticTextCell: "Местоположение")
        showHideFullScreen()
    }
    
    func testOpenAndClosedShopCell() throws {
        searchCellAndOpenVC(staticTextCell: "Магазин")
        showHideFullScreen()
    }
}
