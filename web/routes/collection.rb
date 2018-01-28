module Routes
  class Collection < Cuba
    define do
      on(get, root) do
        printings = Queries::CollectionCards.for_user(current_user)

        render('collection/show', printings: printings)
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

            render('collection/show_import', import: import,
                                             printings: printings)
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
