class Task < ApplicationRecord

  def self.possible_combinations()
    n = self.count
    r = 2
    self.factorial(n) / (self.factorial(r) * self.factorial(n - r))
  end

  def self.factorial(n=0)
    (1..n).inject(:*)
  end
end
