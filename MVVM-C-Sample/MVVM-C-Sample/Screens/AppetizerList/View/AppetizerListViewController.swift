//
//  AppetizerListViewController.swift
//  MVVM-C-Sample
//
//  Created by Umair on 12/05/2025.
//

import UIKit
import Combine

class AppetizerListViewController: UIViewController {

    var viewModel : AppetizerListViewModel
    weak var coordinator : AppCoordinator?
    var cancellables : Set<AnyCancellable> = []
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "AppetizerListTableViewCell", bundle: nil), forCellReuseIdentifier: "AppetizerListTableViewCell")
        return tableView
    }()
    
    required init?(coder: NSCoder, viewModel: AppetizerListViewModel, coordinator: AppCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) needs to be implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUserInterface()
        Task{
            await fetchAppetizers()            
        }
    }
    
    
    func setupUserInterface(){
        title = "Appetizer List"

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        stackView.addArrangedSubview(tableView)
    }
    
    func fetchAppetizers() async{
        
        do{
            try await viewModel.getAppetizerList()
            DispatchQueue.main.async {[weak self] in
                self?.tableView.reloadData()
            }
        }catch{
            fatalError(error.localizedDescription)
        }
        
    }
    
}

extension AppetizerListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.appetizers.count)
        return viewModel.appetizers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppetizerListTableViewCell") as? AppetizerListTableViewCell else {return UITableViewCell()}
        cell.setup(data: viewModel.appetizers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToAppetizerDetail(appetizer: viewModel.appetizers[indexPath.row])
    }
}
