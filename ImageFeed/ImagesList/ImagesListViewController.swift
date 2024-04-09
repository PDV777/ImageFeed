import UIKit

class ImagesListViewController: UIViewController {
    
    //    MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    //    MARK: - private propeties
    private let showSingleImageSequeIdentifier = "ShowSingleImage"
    private let photosName: [String] = Array(0..<20).map{"\($0)"}
    private lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru-RU")
        return formatter
    }()
    //    MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSequeIdentifier {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let image = UIImage(named: photosName[indexPath.row])
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}
// MARK: - extensions ImagesListViewController

extension ImagesListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //1 обязательный метод определяет количество ячеек в секции таблицы
        return photosName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //2 обязательный метод протокола должен возвращать ячейку
        let cell = tableView.dequeueReusableCell(withIdentifier:ImagesListCell.reuseIdentifier, for: indexPath)
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}
extension ImagesListViewController {
    func configCell(for cell:ImagesListCell,with indexPath:IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        cell.imageViewCell.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        let isliked = indexPath.row % 2 == 0
        let likeImage = isliked ? UIImage(named: "LikeButtonOn"): UIImage(named: "LikeButtonOff")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
extension ImagesListViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //метод отвечает за тап
        performSegue(withIdentifier: showSingleImageSequeIdentifier, sender: indexPath) // открывает картинку в ячейке
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}
