//
//  QuickFocusListViewController.swift
//  HeadSpaceFocus
//
//  Created by 최영재 on 2022/06/27.
//

import UIKit

class QuickFocusListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathing: [QuickFocus] = QuickFocus.breathing
    let walking: [QuickFocus] = QuickFocus.walking
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    typealias Item = QuickFocus
    enum Section: CaseIterable {
        case breath
        case walk
        
        var title: String {
            switch self {
            case .breath: return "First Section"
            case .walk: return "Second Section"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else { return nil }
            
            cell.configure(item)
            return cell
        })
        
        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else { return nil }
            
            let allSections = Section.allCases
            header.titleLabel.text = allSections[indexPath.section].title
            return header
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breath, .walk])
        snapshot.appendItems(breathing, toSection: .breath)
        snapshot.appendItems(walking, toSection: .walk)
        datasource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
