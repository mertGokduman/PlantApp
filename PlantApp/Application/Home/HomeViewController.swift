//
//  HomeViewController.swift
//  PlantApp
//
//  Created by Mert Gökduman on 30.03.2023.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel = HomeViewModel()

    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: self.collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getQuestions()
        viewModel.getCategories()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bind()
    }

    // MARK: - BIND VIEWMODEL DATAS
    private func bind() {

        viewModel.questions.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        viewModel.categories.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - SETUP UI
    private func setupUI() {

        view.backgroundColor = CustomColors.bgColor

        headerView.setupView(titleText: "Welcome, plant lover!",
                             greetingText: "Good Afternoon! ⛅",
                             searchPlaceholderText: "Search for plants")
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 185)
        ])

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.setupCollectionView()
        self.collectionView.reloadData()
    }

    // MARK: - COLLECTIONVIEW SETUPS
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        self.registerCollectionView()
    }

    private func registerCollectionView() {
        let nibs = [PremiumCVC.self, GetStartedCVC.self, CategoriesCVC.self]
        collectionView.registerNibs(withClassesAndIdentifiers: nibs)
        collectionView.register(UINib(nibName: "HomeHeader",
                                      bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HomeHeader")
    }

    // MARK: - ROUTE FUNCTION
    private func routeToPayWall() {
        let vc = PayWallViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.isComeFromHome = true
        self.present(vc, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.typeArray.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.typeArray[section]
        switch section {
        case .premium:
            return 1
        case .getStarted:
            return 1
        case .categories:
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.typeArray[indexPath.section]
        switch section {
        case .premium:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PremiumCVC",
                                                                for: indexPath) as? PremiumCVC else { return UICollectionViewCell() }
            return cell
        case .getStarted:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GetStartedCVC",
                                                                for: indexPath) as? GetStartedCVC else { return UICollectionViewCell() }
            cell.fillCell(with: viewModel.questions.value)
            cell.delegate = self
            return cell
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCVC",
                                                                for: indexPath) as? CategoriesCVC else { return UICollectionViewCell() }
            cell.fillCell(with: viewModel.categories.value ?? [])
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.typeArray[indexPath.section]
        switch section {
        case .premium:
            self.routeToPayWall()
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = viewModel.typeArray[indexPath.section]
        switch section {
        case .premium:
            return CGSize(width: getScreenSize().width,
                          height: 112)
        case .getStarted:
            return CGSize(width: getScreenSize().width,
                          height: 224)
        case .categories:
            return CGSize(width: getScreenSize().width,
                          height: calculateCategoryCollectionHeight())
        }
    }

    private func calculateCategoryCollectionHeight() -> CGFloat {
        guard let count = viewModel.categories.value?.count else { return 0 }
        let rowCount = count / 2
        var height: CGFloat = 0
        if count != 0 && count % 2 == 0 {
            height = CGFloat((rowCount * 152) + ((rowCount - 1) * 10))
        } else {
            height = CGFloat(((rowCount + 1) * 152) + (rowCount * 10))
        }
        return height
    }
}

// MARK: - GetStartedDelegate
extension HomeViewController: GetStartedDelegate {

    func cellTapped(url: String?) {
        guard let url = url else { return }
        let vc = WebViewController()
        vc.urlString = url
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

// MARK: - TabBarItemable
extension HomeViewController: TabBarItemable {
    var tabItem: TabItem {
        return TabItem(title: "Home",
                       image: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate),
                       selectedImage: UIImage(named: "home")?.withRenderingMode(.alwaysTemplate),
                       isEnable: true)
    }
}
