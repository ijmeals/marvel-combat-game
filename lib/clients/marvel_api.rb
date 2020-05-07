require "httparty"
require "digest"
require_relative "./../services/Exceptions/marvel_api.rb"

class MarvelApi 
  include HTTParty
  @@BASE_URI = "https://gateway.marvel.com/v1/public/"

  def initialize(config = { private_key: nil, public_key: nil })
    raise Exceptions::MarvelApi.new("Missing the private key for Marvel API") if config[:private_key].nil?
    raise Exceptions::MarvelApi.new("Missing the public key for Marvel API") if config[:public_key].nil?

    @public_key = config[:public_key]
    @private_key = config[:private_key]
    @time = Time.now.to_i
    @hash = Digest::MD5.hexdigest("#{@time}#{@private_key}#{@public_key}")
  end
  
  def find(name)
    raise Exceptions::MarvelApi.new("Character name must include at least one character and cannot be a empty space") if name.nil? || name.strip.empty?

    options = {
      query: {
        apikey: @public_key,
        ts: @time,
        hash: @hash,
        name: name
      }
    }

    res = self.fetch_response("#{@@BASE_URI}characters", options)
    http_code = res.code.to_i

    raise Exceptions::MarvelApi.new("Error when interacting with the Marvel API: '#{res["message"]}'", {
      options: options,
      base_uri: @@BASE_URI,
      res_http_code: http_code
    }) unless http_code === 200

    return res
  end

  private

  def fetch_response(uri, options)
    begin
      return self.class.get(uri, options)
    rescue Net::OpenTimeout
      raise Exceptions::MarvelApi.new("A Timeout Occurred When Trying to Reach the Marvel API", {
        options: options,
        base_uri: uri
      })
    end
  end
end