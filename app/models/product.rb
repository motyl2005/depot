class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_no_line_items
  validates :image_url, uniqueness: true
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, length: {minimum: 10, message: "The title should have at least 10 characters"}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with:   %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }


  def self.latest
    Product.order(:updated_at).last
  end

  private

  def ensure_no_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
