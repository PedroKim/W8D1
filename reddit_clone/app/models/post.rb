# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
    validates :title, presence: true

    belongs_to :author, class_name: :User, foreign_key: :author_id
    has_many :post_subs, dependent: :destroy, inverse_of: :post
    has_many :subs, through: :post_subs, source: :sub
    has_many :comments

    def comments_by_parent_id
        # hash = Hash.new { |k, v| k[v] = [] }
        self.comments.each do |comment|
            child_comments = comment.child_comments
            hash[comment.parent_comment_id] = child_comments
        end
    end


end
