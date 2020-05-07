module MarvelCombat
  class Word
    def self.pick(opts = { description: "", position: 0 })
      return opts[:description] if opts[:description].strip.length === 0

      pos = opts[:position]
      word = opts[:description].split(" ")[pos - 1]

      word || ""
    end


    def self.calc_points(opts = { word: "", description: "" })
      return 1000 + "radioactive".length if opts[:description].include?("radioactive")
      return 1000 + "gamma".length if opts[:description].include?("gamma")

      opts[:word].length
    end
  end
end