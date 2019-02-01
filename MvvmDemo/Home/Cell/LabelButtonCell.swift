
import UIKit
import RxSwift

class LabelButtonCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        autoLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    // MARK: - setupUI && autoLayout

    private func setupUI() {

        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(rightButton1)
        contentView.addSubview(rightButton2)
    }

    private func autoLayout() {

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        rightButton1.snp.makeConstraints { (make) in
            make.right.equalTo(-14)
            make.height.equalToSuperview()
            make.width.equalTo(58)
            make.centerY.equalToSuperview()
        }

        rightButton2.snp.makeConstraints { [unowned self] (make) in
            make.right.equalTo(self.rightButton1.snp.left)
            make.height.equalTo(18)
            make.width.equalTo(58)
            make.centerY.equalToSuperview()
        }

        subTitleLabel.snp.makeConstraints { [unowned self] (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(10)
            make.right.equalTo(self.rightButton2.snp.left).offset(-10)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    // MARK: - setter && getter

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = .clear

        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .clear

        return label
    }()

    lazy var rightButton1: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.contentHorizontalAlignment = .right
        
        return button
    }()
    
    lazy var rightButton2: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()

    var data: (title: String, subTitle: String, rightText1: String, rightText2: String) = ("", "", "", "") {
        didSet {
            titleLabel.text = data.title
            subTitleLabel.text = data.subTitle
            rightButton1.setTitle(data.rightText1, for: .normal)
            rightButton2.setTitle(data.rightText2, for: .normal)
        }
    }
}
