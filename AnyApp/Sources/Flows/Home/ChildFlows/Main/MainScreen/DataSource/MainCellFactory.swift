import UIKit
import UI

final class MainCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Common

    func makeShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateShimmerView.self,
            for: indexPath
        )
    }
    func makeShimerHeader(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateShimmerHeader.self,
            for: indexPath
        )
    }

    // MARK: - Cells
    func makeTemplateCardCell(
        for indexPath: IndexPath,
        with props: TemplateCardView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateCardView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateAccountCell(
        for indexPath: IndexPath,
        with props: TemplateAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateDepositeCell(
        for indexPath: IndexPath,
        with props: TemplateDepositsView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateDepositsView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateHeaderCell(
        for indexPath: IndexPath,
        with props: TemplateHeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateHeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeSpacerSections(
        for indexPath: IndexPath,
        with props: BaseTableSpacer.Props
    ) -> UITableViewCell {
        tableView.dequeueSpacer(props, for: indexPath)
            .backgroundColor(BackgroundStyle.backgroundPrimary.color)
    }
    
    func makeErrorDownloadCell(
        for indexPath: IndexPath,
        with props: ErrorDownloadCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ErrorDownloadCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}
