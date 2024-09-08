//
//  ShopGridCell.swift
//  MiniApp
//
//  Created by Алексей Гвоздков on 07.09.2024.
//

import UIKit
import Kingfisher

final class ShopGridCell: UICollectionViewCell {
    static let cellIdentifier = "GridCell"
    private let universalUIElements = UniversalUIElements()
    private let animateView = AnimateView()
    private let likeButtonsView = LikeButtonsView()
    private let cartButtonView = CartButtonView()
    private let unitMeasurementView = UnitMeasurementView()
    private let coutingsButtonsView  = CoutingsButtonsView()
    private var productWeight: Float = 0.0
    private var productCount: Int = 0
    private var itemTotalPrice: Float = 0.0
    private var itemPrice: Float = 0.0
    
    private lazy var shadowContainerView: UIView = {
        return universalUIElements.createShadowContainerView()
    }()
    
    private lazy var productImage: UIImageView = {
        let image = universalUIElements.createProductImageView(widthAnchor: 168,
                                                               heightAnchor: 168)
        image.layer.cornerRadius = 4
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var ratingImage: UIImageView = {
        return universalUIElements.createRatingImageView()
    }()
    
    private lazy var ratingLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 12,
                                               weight: .light,
                                               textColor: .black)
    }()
    
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingImage, ratingLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var discountLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .bold,
                                               textColor: Colors.redDiscount)
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = universalUIElements.createLabel(fontSize: 12,
                                                    weight: .light,
                                                    textColor: .black)
        label.sizeToFit()
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var countryOriginLabel: UILabel = {
        let label = universalUIElements.createLabel(fontSize: 12,
                                                    weight: .regular,
                                                    textColor: .gray)
        return label
    }()
    
    private lazy var newPriceIntegerLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 20,
                                               weight: .bold,
                                               textColor: .black)
    }()
    
    private lazy var newPriceWholeLabel: UILabel = {
        return universalUIElements.createLabel(fontSize: 16,
                                               weight: .bold,
                                               textColor: .black)
    }()
    
    private lazy var unitView: UIView = {
        return universalUIElements.createUnitView()
    }()
    
    private lazy var oldPriceLabel: UILabel = {
        let label = universalUIElements.createLabel(fontSize: 12,
                                                    weight: .regular,
                                                    textColor: .gray)
        return label
    }()
    
    private lazy var promotionalView: UIView = {
        return universalUIElements.createPromotionalView(color: .clear, text: "")
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        universalUIElements.setupCellAppearance(for: contentView)
        constraintsSettingsView()
        setupShoppingListButtonAction()
        setupLikeButtonAction()
        setupCartButtonActions()
        satupMinusButtonCoutingsButtonsView()
        satupPlusButtonCoutingsButtonsView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingLabel.text = nil
    }
    
    private func constraintsSettingsView() {
        likeButtonsView.translatesAutoresizingMaskIntoConstraints = false
        coutingsButtonsView.translatesAutoresizingMaskIntoConstraints = false
        cartButtonView.translatesAutoresizingMaskIntoConstraints = false
        unitMeasurementView.translatesAutoresizingMaskIntoConstraints = false
        
        coutingsButtonsView.isHidden = true
        unitMeasurementView.isHidden = true
        
        addSubview(shadowContainerView)
        shadowContainerView.addSubview(contentView)
        contentView.addSubview(productImage)
        productImage.addSubview(ratingStack)
        productImage.addSubview(discountLabel)
        
        contentView.addSubview(promotionalView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(countryOriginLabel)
        contentView.addSubview(newPriceIntegerLabel)
        contentView.addSubview(newPriceWholeLabel)
        contentView.addSubview(unitView)
        contentView.addSubview(oldPriceLabel)
        contentView.addSubview(cartButtonView)
        contentView.addSubview(likeButtonsView)
        contentView.addSubview(unitMeasurementView)
        contentView.addSubview(coutingsButtonsView)
    
        
        NSLayoutConstraint.activate([
            shadowContainerView.topAnchor.constraint(equalTo: topAnchor),
            shadowContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: shadowContainerView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: shadowContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: shadowContainerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: shadowContainerView.bottomAnchor),
            
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.centerXAnchor.constraint(equalTo: shadowContainerView.centerXAnchor),
            
            promotionalView.topAnchor.constraint(equalTo: productImage.topAnchor),
            promotionalView.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            promotionalView.widthAnchor.constraint(equalToConstant: 84),
            promotionalView.heightAnchor.constraint(equalToConstant: 16),
            
            ratingStack.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 4),
            ratingStack.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            
            discountLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -4),
            discountLabel.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            
            productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productNameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            countryOriginLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            countryOriginLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            newPriceIntegerLabel.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 70),
            newPriceIntegerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            newPriceWholeLabel.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 71),
            newPriceWholeLabel.leadingAnchor.constraint(equalTo: newPriceIntegerLabel.trailingAnchor, constant: 2),
            
            unitView.leadingAnchor.constraint(equalTo: newPriceWholeLabel.trailingAnchor, constant: 4),
            unitView.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 70),
            
            oldPriceLabel.topAnchor.constraint(equalTo: newPriceIntegerLabel.bottomAnchor),
            oldPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            cartButtonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            cartButtonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cartButtonView.widthAnchor.constraint(equalToConstant: 48),
            cartButtonView.heightAnchor.constraint(equalToConstant: 36),
            
            coutingsButtonsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            coutingsButtonsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coutingsButtonsView.widthAnchor.constraint(equalToConstant: 160),
            coutingsButtonsView.heightAnchor.constraint(equalToConstant: 36),
            
            unitMeasurementView.bottomAnchor.constraint(equalTo: coutingsButtonsView.topAnchor, constant: -4),
            unitMeasurementView.heightAnchor.constraint(equalToConstant: 28),
            unitMeasurementView.widthAnchor.constraint(equalToConstant: 160),
            unitMeasurementView.centerXAnchor.constraint(equalTo: coutingsButtonsView.centerXAnchor),
            
            likeButtonsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeButtonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likeButtonsView.heightAnchor.constraint(equalToConstant: 64),
            likeButtonsView.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func cellUpdate(product: ShopProductModel) {
        if let imageURL = URL(string: product.photo) {
            productImage.kf.setImage(with: imageURL)
        }
        
        UpdateUniversalUIElements.maxLengthProductName(productNameLabel, product.name)

        itemPrice = product.discountedPrice
        
        unitMeasurementView.unitMeasurement = product.unitMeasurement
        
        UpdateUniversalUIElements.updateCountryOriginLabel(city: product.countryOrigin, label: countryOriginLabel)
        
        UpdateUniversalUIElements.updateUnitView(unitView: unitView, unitMeasurement: product.unitMeasurement)
        
        UpdateUniversalUIElements.updateDiscountLabel(discountPrice: product.discount,
                                                      discountLabel: discountLabel)
        
        UpdateUniversalUIElements.updateRatingLabel(ratingStack: ratingStack,
                                                    rating: product.rating)
        
        UpdateUniversalUIElements.updatePrice(newPriceIntegerLabel: newPriceIntegerLabel,
                                              newPriceWholeLabel: newPriceWholeLabel,
                                              discountedPrice: product.discountedPrice)
        
        UpdateUniversalUIElements.updateOldPriceLabel(oldPrice: product.oldPrice,
                                                      discountedPrice: product.discountedPrice,
                                                      oldPriceLabel: oldPriceLabel)
        
        UpdateUniversalUIElements.updatePromotionalView(promotionalView: promotionalView,
                                                        promotion: product.promotionalProduct)
    }
    
    private func updateVisibility(isHidden: Bool) {
        cartButtonView.isHidden = isHidden
        newPriceIntegerLabel.isHidden = isHidden
        newPriceWholeLabel.isHidden = isHidden
        oldPriceLabel.isHidden = isHidden
        unitView.isHidden = isHidden
        unitMeasurementView.isHidden = !isHidden
        coutingsButtonsView.isHidden = !isHidden
    }

    private func updateUIForProductQuantity(isHidden: Bool, widthAnchor: CGFloat, heightAnchor: CGFloat) {
        guard productWeight < 0.1, productCount < 1 else { return }
        
        if isHidden {
            animateView.animateViewAppearance(unitMeasurementView, coutingsButtonsView)
            self.updateVisibility(isHidden: true)
        } else {
                self.updateVisibility(isHidden: false)
        }

        animateView.animatioinsImageProfuct(imageView: productImage,
                                            widthAnchor: widthAnchor,
                                            heightAnchor: heightAnchor)
    }
    
    private func updateProductQuantity(operation: String, isInitial: Bool = false) {
        if isInitial && itemTotalPrice > 0 {
            return
        }

        switch operation {
        case "+":
            itemTotalPrice += (unitMeasurementView.unitMeasurement == 1) ? itemPrice : itemPrice * 0.1
            if unitMeasurementView.unitMeasurement == 1 {
                productCount += 1
            } else {
                productWeight += 0.1
                productWeight = round(productWeight * 10) / 10.0
            }
        case "-":
            itemTotalPrice -= (unitMeasurementView.unitMeasurement == 1) ? itemPrice : itemPrice * 0.1
            if unitMeasurementView.unitMeasurement == 1 {
                productCount -= 1
            } else {
                productWeight -= 0.1
                productWeight = round(productWeight * 10) / 10.0
            }
        default:
            break
        }
        
        coutingsButtonsView.priceLabelText = String(format: "%.2f", itemTotalPrice)
        coutingsButtonsView.productWeightText = (unitMeasurementView.unitMeasurement == 1) ? "\(productCount) шт" : "\(productWeight) кг"
    }

    
    // MARK: - Actions Buttons
    private func setupShoppingListButtonAction() {
        likeButtonsView.shoppingListButtonAction = { [weak self] in
            self?.shoppingListButton()
        }
    }
    
    private func setupLikeButtonAction() {
        likeButtonsView.likeButtonAction = { [weak self] in
            self?.likeButton()
        }
    }
    
    private func setupCartButtonActions() {
        cartButtonView.cartButtonAction = { [weak self] in
            self?.cartButtonAction()
        }
    }
    
    private func satupMinusButtonCoutingsButtonsView() {
        coutingsButtonsView.minusButtonAction = { [weak self] in
            self?.minusButtonAction()
        }
    }
    
    private func satupPlusButtonCoutingsButtonsView() {
        coutingsButtonsView.plusButtonAction = { [weak self] in
            self?.plusButtonAction()
        }
    }
    
    private func shoppingListButton() {
        print("shoppingListButton")
    }
    
    private func likeButton() {
        print("likeButton")
    }
    
    private func cartButtonAction() {
        updateUIForProductQuantity(isHidden: true,
                                   widthAnchor: 168,
                                   heightAnchor: 148)
     
        updateProductQuantity(operation: "+")
    }
    
    private func minusButtonAction() {
        updateProductQuantity(operation: "-")
        
        updateUIForProductQuantity(isHidden: false,
                                   widthAnchor: 168,
                                   heightAnchor: 168)
    }
    
    private func plusButtonAction() {
        updateProductQuantity(operation: "+")
    }
}

