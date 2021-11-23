//
//  DemoEditorTest.swift
//  LittlePink
//
//  Created by 欧阳文 on 2021/11/22.
//

import UIKit

class DemoEditorTest: UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate{

    private let photos = [UIImage(named: "house_icon_group"),UIImage(named:"house_icon_group"), UIImage(named:"house_icon_group"), UIImage(named: "house_icon_group"),UIImage(named: "house_icon_group"),UIImage(named:"house_icon_group"), UIImage(named:"house_icon_group"), UIImage(named: "house_icon_group")]
    private lazy var collectView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.scrollDirection = .horizontal
        
        let collectView = UICollectionView(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:90), collectionViewLayout: layout)
        collectView.backgroundColor = .yellow
        collectView.register(VCCell.self, forCellWithReuseIdentifier: "CVCellID")
        collectView.dataSource = self
        collectView.delegate = self
        return collectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(collectView)
        setUI()
    }
    
    private func setUI(){//使用aolayout
        collectView.translatesAutoresizingMaskIntoConstraints = true
        collectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        collectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("图片数量\(photos.count)")
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellID", for: indexPath) as! VCCell
        cell.imageIv.image = photos[indexPath.item]
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class VCCell:UICollectionViewCell {
    
    lazy var imageIv:UIImageView = {
        let imageIv = UIImageView()
        imageIv.contentMode = .scaleAspectFill
        imageIv.translatesAutoresizingMaskIntoConstraints = false
        return imageIv
    }()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        addSubview(imageIv)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        imageIv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageIv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imageIv.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageIv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
