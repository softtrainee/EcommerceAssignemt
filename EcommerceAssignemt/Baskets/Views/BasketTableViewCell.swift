//
//  BasketTableViewCell.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit
import AlamofireImage



protocol BasketTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(_ basket: ProductList.ProductModel??)
    func didTapStepper(_ basket: ProductList.ProductModel??, piece: Double?)
}



final class BasketTableViewCell: UITableViewCell {
    //MARK: - Properties
    var delegate: BasketTableViewCellDelegate?
    var basket: ProductList.ProductModel? {
        didSet {
            guard let basket = basket,
                  let imageUrl = basket.imageUrl?.first,
                  let title = basket.title,
                  let price = basket.price,
                  let stepperValue = basket.count
                   else {
                return
            }
            guard let url = URL(string: imageUrl) else {
                return
            }
            productImageView.af_setImage(withURL: url)
            productTitleLabel.text = "\(title)"
            productPriceLabel.text = "\(price.priceFormatted)"
            stepper.value = Double(stepperValue)
            stepperLabel.text = "\(stepperValue)"
            
        }
    }
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trashIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapDelete(_:)), for: .touchUpInside)
        return button
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(didTapStepper(_:)), for: .touchUpInside)
        return stepper
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.numberOfLines = 0
        label.textColor = .black
        label.layer.cornerRadius = 8
        return label
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupCell() {
        setupCustomView()
        setupImageView()
        setupDeleteButton()
        setupStepperLabel()
        setupStepper()
        setupProductTitleLabel()
        setupProductPriceLabel()

    }
    
    private func setupCustomView() {
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        ])
    }
    
    private func setupImageView() {
        customView.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: customView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 5.0),
            productImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 82),
            productImageView.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
    
    private func setupDeleteButton() {
        customView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5.0),
            deleteButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5.0),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupStepperLabel() {
        customView.addSubview(stepperLabel)
        stepperLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepperLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5.0),
            stepperLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5.0),
        ])
    }
    
    private func setupStepper() {
        customView.addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepper.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            stepper.trailingAnchor.constraint(equalTo: stepperLabel.leadingAnchor, constant: -6.0)
        ])
    }
    
    private func setupProductTitleLabel() {
        customView.addSubview(productTitleLabel)
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5.0),
            productTitleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -20.0),
            productTitleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5.0)
        ])
    }
    
    private func setupProductPriceLabel() {
        customView.addSubview(productPriceLabel)
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPriceLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5.0),
            productPriceLabel.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -6.0),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 5.0)
        ])
    }
    
    @objc private func didTapStepper(_ sender: UIStepper) {
        delegate?.didTapStepper(basket, piece: sender.value)
    }
    
    @objc private func didTapDelete(_ sender: UIButton) {
        delegate?.didTapDeleteButton(basket)
    }
    @objc private func didTapAddBasket() {
//        delegate?.didTapAddBasket(product, piece: 1)
    }
}

