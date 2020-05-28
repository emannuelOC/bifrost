
import UIKit

fileprivate enum ElementListProperty: String {
    case backgroundColor = "backgroundColor"
}

class ElementList: BaseComponent {
    
    fileprivate var elementListView: ElementListView?
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        let listView = ElementListView(items: dynamicComponent.children ?? [], delegate: actionDelegate)
        listView.translatesAutoresizingMaskIntoConstraints = false
        self.elementListView = listView
        self.addProperties(properties: dynamicComponent.properties)
        return listView
        
    }
    
}

extension ElementList {
    
    fileprivate func addProperties(properties: [DynamicProperty]?) {
        guard let properties = properties else { return }
        for property in properties {
            self.identifyAndApply(property: property)
        }
    }
    
    fileprivate func identifyAndApply(property: DynamicProperty) {
        if property.name == ElementListProperty.backgroundColor.rawValue {
            elementListView?.color = property.value as? UIColor
        }
    }
    
}

private class ElementListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var components = [DynamicComponent]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: DynamicActionDelegate
    
    var color: UIColor? {
        didSet {
            tableView.backgroundColor = color
            tableView.reloadData()
        }
    }
    
    init(items: [DynamicComponent], delegate: DynamicActionDelegate) {
        self.components = items
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() {
        addSubview(tableView)
        self.topAnchor(equalTo: tableView.topAnchor)
            .bottomAnchor(equalTo: tableView.bottomAnchor)
            .leadingAnchor(equalTo: tableView.leadingAnchor)
            .trailingAnchor(equalTo: tableView.trailingAnchor)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        if let color = color {
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        }
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        let component = components[indexPath.row]
        if let view = try? DynamicView.createView(dynamicsComponent: component,
                                                  actionDelegate: delegate) {
            cell.contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        
        
            let marginApplier = MarginApplier()
            marginApplier.tryApplyMargin(component: component, to: view, in: cell.contentView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
