module Web
  module Routes
    class Collection < Web::Server
      define do
        require_login!

        on(get, root) do
          printings = Queries::CollectionCards.full_for_user(current_user)
          dbs = DeckDatabase.select(:key, :name, :max_score).all

          render('collection/show', printings: printings, rated_decks: dbs)
        end

        on('imports') do
          on(get, root) do
            imports = Queries::ImportList.for_user(current_user)

            render('collection/imports', imports: imports)
          end

          on(':id') do |id|
            import = Import.first(id: id)

            on(delete, root) do
              Services::Collection::DeleteImport.perform(import)

              redirect_to('/collection/imports')
            end

            on(get, root) do |id|
              printings = Queries::ImportPrintings.for_import(import)
              dbs = DeckDatabase.select(:key, :name, :max_score).all

              render('collection/show_import', import: import,
                                               printings: printings,
                                               rated_decks: dbs)
            end

            on('list') do
              cards = Queries::ImportCards.for_import(import)

              render('cards/list', cards: cards, import: import)
            end

            on('deckbox') do
              printings = Queries::ImportPrintings.for_import(import)

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
            render('collection/import')
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
