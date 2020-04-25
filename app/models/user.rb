# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :profile_image

  validates :name,
            length: { minimum: 2, maximum: 20 },
            presence: true

  validates :introduction,
            length: { maximum: 50 }

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
