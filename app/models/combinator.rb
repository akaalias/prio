class Combinator
  def self.possible_combinations()
    self.unique_combinations(Task.all.map(&:id)).count
  end

  def self.unique_combinations(ids)
    return [] if ids.length < 2

    all_combinations = []

    for i1 in ids
      for i2 in ids
        if i1 != i2
          contains = false
          for c in all_combinations
            if c[1] == i1 and c[0] == i2
              contains = true
            end
          end
          unless contains
            all_combinations << [i1, i2]
          end
        end
      end
    end

    return all_combinations
  end
end
