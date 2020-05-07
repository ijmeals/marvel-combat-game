require_relative "./../../clients/marvel_api.rb"

module MarvelCombat
  class Character
    def self.find(name)
      characters = Array.new

      api = MarvelApi.new({
        public_key: ENV["MARVEL_API_PUBLIC_KEY"],
        private_key: ENV["MARVEL_API_PRIVATE_KEY"]
      })

      res = api.find(name);

      res["data"] && res["data"]["results"].each do | row |
        characters.push({
          name: row["name"],
          description: row["description"]
        })
      end

      characters
    end
  end
end
