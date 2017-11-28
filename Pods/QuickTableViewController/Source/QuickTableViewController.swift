//
//  QuickTableViewController.swift
//  QuickTableViewController
//
//  Created by Ben on 25/08/2015.
//  Copyright (c) 2015 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

/// A table view controller that shows `tableContents` as formatted sections and rows.
open class QuickTableViewController: UIViewController,
  UITableViewDataSource,
  UITableViewDelegate,
  SwitchCellDelegate {

  /// A Boolean value indicating if the controller clears the selection when the collection view appears.
  open var clearsSelectionOnViewWillAppear = true

  /// Returns the table view managed by the controller object.
  open private(set) var tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)

  /// The layout of sections and rows to display in the table view.
  open var tableContents: [Section] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  // MARK: - Initialization

  /**
   Initializes a table view controller to manage a table view of a given style.

   - parameter style: A constant that specifies the style of table view that the controller object is to manage (`.plain` or `.grouped`).

   - returns: An initialized `QuickTableViewController` object.
   */
  public convenience init(style: UITableViewStyle) {
    self.init(nibName: nil, bundle: nil)
    tableView = UITableView(frame: CGRect.zero, style: style)
  }

  deinit {
    tableView.dataSource = nil
    tableView.delegate = nil
  }

  // MARK: - UIViewController

  open override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    tableView.dataSource = self
    tableView.delegate = self
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let indexPath = tableView.indexPathForSelectedRow, clearsSelectionOnViewWillAppear {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  // MARK: - UITableViewDataSource

  open func numberOfSections(in tableView: UITableView) -> Int {
    return tableContents.count
  }

  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableContents[section].rows.count
  }

  open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return tableContents[section].title
  }

  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = tableContents[indexPath.section].rows[indexPath.row]
    let cell =
      tableView.dequeueReusableCell(withIdentifier: row.cellReuseIdentifier) ??
      row.cellType.init(style: row.cellStyle, reuseIdentifier: row.cellReuseIdentifier)

    cell.defaultSetUp(with: row)
    (cell as? Configurable)?.configure(with: row)
    (cell as? SwitchCell)?.delegate = self
    row.customize?(cell, row)

    return cell
  }

  open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return tableContents[section].footer
  }

  // MARK: - UITableViewDelegate

  open func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return tableContents[indexPath.section].rows[indexPath.row].isSelectable
  }

  open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = tableContents[indexPath.section]
    let row = section.rows[indexPath.row]

    switch (section, row) {
    case let (radio as RadioSection, option as OptionRow<UITableViewCell>):
      let indexPaths: [IndexPath] = radio.toggle(option).map {
        IndexPath(row: $0, section: indexPath.section)
      }
      tableView.reloadRows(at: indexPaths, with: .automatic)

    case let (_, option as OptionRow<UITableViewCell>):
      // Allow OptionRow to be used without RadioSection.
      option.isSelected = !option.isSelected
      tableView.reloadRows(at: [indexPath], with: .automatic)

    case (_, is TapActionRow<TapActionCell>):
      tableView.deselectRow(at: indexPath, animated: true)
      row.action?(row)

    case let (_, row) where row.isSelectable:
      row.action?(row)

    default:
      break
    }
  }

  // MARK: - SwitchCellDelegate

  open func switchCell(_ cell: SwitchCell, didToggleSwitch isOn: Bool) {
    guard
      let indexPath = tableView.indexPath(for: cell),
      let row = tableContents[indexPath.section].rows[indexPath.row] as? SwitchRow
    else {
      return
    }

    row.switchValue = isOn
  }

}
