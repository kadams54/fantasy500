# config/initializers/will_paginate.rb
#
# This extension code was written by Isaac Bowen, originally found
# at http://isaacbowen.com/blog/using-will_paginate-action_view-and-bootstrap/

require "will_paginate/view_helpers/action_view"

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash
      # Taken from original will_paginate code to handle if the helper is not passed a collection object.
      collection ||= infer_collection_from_controller
      options[:renderer] ||= SpectreLinkRenderer
      super.try :html_safe
    end

    class SpectreLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag.nav tag.ul(html, class: ul_class)
      end

      def page_number(page)
        tag.li link(page, page, rel: rel_value(page)), class: ["page-item", ("active" if page == current_page)].compact.join(" ")
      end

      def gap
        tag.li tag.span("&hellip;".html_safe), class: "page-item"
      end

      def previous_or_next_page(page, text, classname)
        tag.li link(text, page || "#"), class: ["page-item", ("disabled" unless page)].compact.join(" ")
      end

      def ul_class
        container_attributes[:class]
      end
    end
  end
end
