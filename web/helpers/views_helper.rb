module Web
  module Helpers
    module ViewsHelper
      def haml_icon(name)
        haml_tag('i.fas', class: "fa-#{name}")
      end

      def form(opts)
        opts = {method: 'post'}.merge(opts)

        haml_tag(:form, opts) do
          haml_concat(csrf.form_tag) if opts[:method] != 'get'

          yield
        end
      end

      def delete_button
        haml_tag('button.btn.btn-sm.btn-outline-danger', type: 'submit') do
          haml_icon('trash-alt')
        end
      end

      def delete_form(path, opts = {})
        form(opts) do
          if opts[:method] != 'get'
            haml_tag(:input, type: 'hidden', name: '_method', value: 'delete')
          end

          yield
        end
      end

      def count_badge(count)
        element = 'span.badge.badge-primary.badge-pill'

        haml_tag(element, count, title: "#{count} cards")
      end

      def list_printings(printings)
        partial('printings/_list', with_count: true, printings: printings)
      end
    end
  end
end
