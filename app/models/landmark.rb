class Landmark <ActiveRecord::Base
  belongs_to :figure

  def slug
    name.parameterize
  end

  def self.find_by_slug(slug)
    self.all.find{|item| item.slug == slug}
  end
end
