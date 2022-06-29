//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit

class FocusViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var items: [Focus] = Focus.list
    var curated: Bool = false
    
    enum Section {
        case main
    }
    typealias Item = Focus
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else { return nil }
            
            cell.configure(item)
            return cell
        })
        
        doSnapshot()
        updateTitle()
        collectionView.collectionViewLayout = layout()
        
        collectionView.delegate = self
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        curated.toggle()
        self.items = curated ? Focus.recommendations : Focus.list
        doSnapshot()
        updateTitle()
    }
    
    func doSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        datasource.apply(snapshot)
    }
    
    func updateTitle() {
        let title = curated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension FocusViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "QuickFocus", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "QuickFocusListViewController") as! QuickFocusListViewController
        
        vc.title = items[indexPath.item].title
        navigationController?.pushViewController(vc, animated: true)
    }
}
