module Exceptions
  class MarvelApi < StandardError
    attr_reader :api_params
    def initialize(msg = "Something Unexpected Happen with a Marvel API Call", api_params = nil)
      @api_params = api_params
      super(msg)
    end
  end
end