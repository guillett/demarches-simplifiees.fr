module Redcarpet
  class BareRenderer < Redcarpet::Render::HTML
    include ActionView::Helpers::TagHelper
    include ApplicationHelper

    # won't use rubocop tag method because it is missing output buffer
    # rubocop:disable Rails/ContentTag
    def list(content, list_type)
      tag = list_type == :ordered ? :ol : :ul
      content_tag(tag, content, { class: @options[:class_names_map].fetch(:list) {} }, false)
    end

    def list_item(content, list_type)
      content_tag(:li, content.strip.gsub(/<\/?p>/, ''), {}, false)
    end

    def paragraph(text)
      content_tag(:p, text, { class: @options[:class_names_map].fetch(:paragraph) {} }, false)
    end

    def link(href, title, content)
      content_tag(:a, content, { href:, title: new_tab_suffix(title), **external_link_attributes }, false)
    end

    def autolink(link, link_type)
      return super unless link_type == :url

      link(link, nil, link)
    end

    # rubocop:enable Rails/ContentTag
  end
end