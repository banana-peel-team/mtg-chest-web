module Routes
  class Collection < Cuba
    define do
      on(get, root) do
        printings = Services::Collection::ListCards.perform(current_user)

        render('collection/show', printings: printings)
      end

      on('imports') do
        on(get, root) do
          imports = current_user.imports

          render('collection/imports', imports: imports)
        end

        on(':id') do |id|
          import = Import.first(id: id)

          on('list') do
            printings = import
              .user_printings_dataset
              .association_join(:card)
              .all

            render('cards/list', cards: printings, title: import[:title])
          end

          on(delete, root) do
            Services::Collection::DeleteImport.perform(import)
            redirect_to('/collection/imports')
          end

          on(get, root) do |id|
            printings = import
              .user_printings_dataset
              .association_join(:card)
              .all

            render('collection/show_import', import: import,
                                             printings: printings)
          end
        end
      end

      on('import') do
        on(get, root) do
          render('collection/import')
        end

        on(post, 'mtgmanager', param('import')) do |params|
          title = params['title']

          import = Services::Collection::ImportFile.perform(
            title,
            params['file'][:tempfile],
            current_user
          )

          redirect_to("/collection/imports/#{import[:id]}")
        end
      end
    end
  end
end
