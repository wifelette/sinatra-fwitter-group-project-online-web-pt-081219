# frozen_string_literal: true

module Slugifiable
  extend ActiveSupport::Concern

  def slug
    name.downcase.gsub(' ', '-')
  end

  class_methods do
    # self is the class that Slugifiable is included in
    #
    # Example
    #
    # class Artist < ActiveRecord::Base
    #  include Slugifiable
    # end
    #
    # In this case, `self` is `Artist`, so this class method
    # becomes:
    #
    # def self.find_by_slug
    #   Artist.all.find do |record|
    #     record.slug == slug
    #   end
    # end
    def find_by_slug(slug)
      all.find do |record|
        record.slug == slug
      end
    end
  end
end
