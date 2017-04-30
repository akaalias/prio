class Combinator
  def self.generate_comparisons

    result = []
    for combo in self.unique_combinations(Task.all.map(&:id))
      result << Comparison.new(task_left_id: combo[0], task_right_id: combo[1])
    end
    return result
  end

  def self.possible_combinations()
    n = Task.count
    r = 2
    self.factorial(n) / (self.factorial(r) * self.factorial(n - r))
  end

  def self.factorial(n=0)
    (1..n).inject(:*)
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
