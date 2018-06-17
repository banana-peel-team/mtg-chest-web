require_relative 'presenters/show_collection'
require_relative 'presenters/imports_list'
require_relative 'presenters/import_card_list'

require_relative '../views/collection/show'
require_relative '../views/imports/list'
require_relative '../views/imports/card_list'
require_relative '../views/imports/new'

module Web
  module Routes
    class Collection < Web::Server
      define do
        require_login!

        on(get, root) do
          presenter = Presenters::ShowCollection.new(
            current_user,
            params: req.params
          )

          render_view(Views::Collection::Show, presenter: presenter)
        end

        on('imports') do
          on(get, root) do
            presenter = Presenters::ImportsList.new(current_user)

            render_view(Views::Imports::List, presenter: presenter)
          end

          on(':id') do |id|
            import = Import.first(id: id)

            on(delete, root) do
              Services::Collection::DeleteImport.perform(import)

              redirect_to('/collection/imports')
            end

            on(get, root) do |id|
              presenter = Presenters::ImportCards.new(import)

              render_view(Views::Imports::Show, presenter: presenter)
            end

            on('list') do
              presenter = Presenters::ImportCardList.new(import)
              render_view(Views::Imports::CardList, presenter: presenter)
            end

            on('deckbox') do
              printings = Queries::ImportPrintings.for_import(import).all

              export = Services::Collection::ExportDeckbox.perform(printings)
              csv = Services::CSV::Export.perform(export)

              send_as_file("#{import.safe_title}.csv", csv.string)
            end
          end
        end

        on(post, 'import-list', param('import')) do |params|
          import = Services::Collection::ImportList.perform(
            current_user,
            title: params['title'],
            foil: params['foil'] == '1',
            condition: params['condition'],
            edition_code: params['set'],
            list: params['list'].split(/[\r\n]+/),
          )

          redirect_to("/collection/imports/#{import[:id]}")
        end

        on('import') do
          on(get, root) do
            render_view(Views::Imports::New, {})
          end

          on(post, param('import')) do |params|
            unless params['file']
              # TODO: Error handling.
              redirect_to('/collection/import')
            end

            import = Services::Collection::Import.perform(
              current_user,
              source: params['source'],
              title: params['title'],
              file: params['file'][:tempfile],
            )

            redirect_to("/collection/imports/#{import[:id]}")
          end
        end
      end
    end
  end
end
