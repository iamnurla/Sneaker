//
//  File.swift
//  Task
//
//  Created by Yersultan Nalikhan on 22.05.2021.
//

import UIKit

class SneakerCell: UITableViewCell {
    
    //MARK: - Properties
    
    let brandLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let genderLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        addSubview(brandLbl)
        addSubview(genderLbl)
        addSubview(priceLbl)
        
        brandLbl.anchor(top:topAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 20)
        genderLbl.anchor(top:topAnchor, left: leftAnchor, paddingTop: 45, paddingLeft: 20)
        priceLbl.centerY(inView: self)
        priceLbl.anchor(right: rightAnchor, paddingRight: 20)
        
    }
    
    
    
    
    
    
}
