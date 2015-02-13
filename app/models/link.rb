class Link < ActiveRecord::Base
  after_create :generate_short_link, :get_page_title

  #this method will create a slug using Fixnum#to_s that accepts base as the argument
  def generate_short_link
    self.slug = self.id.to_s(36)
    self.save
  end

  #display short url
  def display_short_url
    ENV['BASE_URL'] + self.slug
  end

  def get_page_title
    PageTitleScrap.perform_async(self.id)
  end


end
