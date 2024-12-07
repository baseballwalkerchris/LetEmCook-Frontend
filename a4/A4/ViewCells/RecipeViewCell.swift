import UIKit
import SnapKit
import SDWebImage

class RecipeViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    private let foodImage = UIImageView()
    private let titleLabel = UILabel()
    private let userLabel = UILabel()
    private let bookmarkButton = UIButton()
    private let timeLabel = UILabel()
    private let servingsLabel = UILabel()
    private let ratingLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let ingredientsStackView = UIStackView()
    
    static let reuse = "RecipeViewCellReuse"
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        setupFoodImage()
        setupTitleLabel()
        setupUserLabel()
        setupBookmarkButton()
        setupTimeServingsRating()
        setupDescriptionLabel()
        setupIngredientsStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure cell function
    func configure(recipe: Recipe) {
        foodImage.image = UIImage(named: recipe.imageUrl)
        titleLabel.text = recipe.title
        userLabel.text = "By \(recipe.userId)"
        timeLabel.text = "\(recipe.time)"
        servingsLabel.text = "\(recipe.servings) serv"
        ratingLabel.text = "\(recipe.ratings)/10"
        descriptionLabel.text = recipe.description
        
        // Clear previous tags and add ingredient tags
        ingredientsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        recipe.ingredients.prefix(4).forEach { ingredient in
            let label = createTagLabel(text: ingredient.name)
            ingredientsStackView.addArrangedSubview(label)
        }
    }
    
    // MARK: - UI Setup
    private func setupFoodImage() {
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        contentView.addSubview(foodImage)
        
        foodImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 2
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupUserLabel() {
        userLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        userLabel.textColor = UIColor.gray
        contentView.addSubview(userLabel)
        
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func setupBookmarkButton() {
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        contentView.addSubview(bookmarkButton)
        
        bookmarkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(20)
        }
    }
    
    private func setupTimeServingsRating() {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, servingsLabel, ratingLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        setupLabel(timeLabel, fontSize: 12)
        setupLabel(servingsLabel, fontSize: 12)
        setupLabel(ratingLabel, fontSize: 12)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.numberOfLines = 3
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupIngredientsStackView() {
        ingredientsStackView.axis = .horizontal
        ingredientsStackView.spacing = 5
        ingredientsStackView.alignment = .center
        contentView.addSubview(ingredientsStackView)
        
        ingredientsStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Helpers
    private func setupLabel(_ label: UILabel, fontSize: CGFloat) {
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        label.textColor = UIColor.gray
    }
    
    private func createTagLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.lightGray
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(40)
        }
        return label
    }
}
