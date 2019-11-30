# frozen_string_literal: true

class Tweet < ActiveRecord::Base
  include Slugifiable

  belongs_to :user
end
