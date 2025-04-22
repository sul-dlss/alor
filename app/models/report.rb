# frozen_string_literal: true

# Class for tracking Channel reports and storing the output file
class Report < ApplicationRecord
  has_one_attached :file
end
