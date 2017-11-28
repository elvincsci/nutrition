//
//  SwitchCell.swift
//  QuickTableViewController
//
//  Created by Ben on 03/09/2015.
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

/// The `SwitchCellDelegate` protocol allows the adopting delegate to respond to the UI interaction.
public protocol SwitchCellDelegate: class {
  /// Tells the delegate that the switch control is toggled.
  func switchCell(_ cell: SwitchCell, didToggleSwitch isOn: Bool)
}


/// A `UITableViewCell` subclass that shows a `UISwitch` as the `accessoryView`.
open class SwitchCell: UITableViewCell, Configurable {

  /// A `UISwitch` as the `accessoryView`.
  public private(set) lazy var switchControl: UISwitch = {
    let control = UISwitch()
    control.addTarget(self, action: .didToggleSwitch, for: .valueChanged)
    return control
  }()

  /// The switch cell's delegate object, which should conform to `SwitchCellDelegate`.
  open weak var delegate: SwitchCellDelegate?

  // MARK: - Configurable

  /// Set up the switch control with the provided row.
  open func configure(with row: Row & RowStyle) {
    if let row = row as? SwitchRow {
      switchControl.isOn = row.switchValue
    }
    accessoryView = switchControl
  }

  // MARK: - Private

  @objc
  fileprivate func didToggleSwitch(_ sender: UISwitch) {
    delegate?.switchCell(self, didToggleSwitch: sender.isOn)
  }

}


private extension Selector {
  static let didToggleSwitch = #selector(SwitchCell.didToggleSwitch(_:))
}
