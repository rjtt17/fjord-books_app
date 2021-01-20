# frozen_string_literal: true

class ChangeRelationshipsFollowridAndFollowingidNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :relationships, :follower_id, false
    change_column_null :relationships, :following_id, false
  end
end
