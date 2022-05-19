# frozen_string_literal: true

module ApplicationHelper
  def nav_item_class(path)
    current_page?(path) ? "bg-gray-100 text-gray-900" : "bg-white text-gray-600 hover:bg-gray-50 hover:text-gray-900"
  end
end
