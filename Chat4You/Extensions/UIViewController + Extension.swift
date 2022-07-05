//
//  UIViewController + Extension.swift
//  Chat4You
//
//  Created by Alex Kulish on 20.06.2022.
//

import UIKit

extension UIViewController {
    
    func configure<T: ConfigureCellProtocol, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to deque \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

