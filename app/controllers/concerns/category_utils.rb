module CategoryUtils
  extend ActiveSupport::Concern

  included do
    before_action :load_categories
  end

  def load_categories
    @categories = Category.all.map{|category| [category.name, category.id]}
  end
end
