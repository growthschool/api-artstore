class Product < ActiveRecord::Base

  def image_url
    "http://placehold.it/100x100"
  end
end

# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price      :integer          default("0")
#
