# frozen_string_literal: true

require 'rails_helper'

# ApiHelper
#
module ApiHelper
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :request
end
