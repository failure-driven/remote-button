#!/usr/bin/env ruby

module Changes
  def self.all
    changes = `git status --porcelain`.chomp.split("\n")

    result = []
    changes.each do |change|
      staged = change[0]
      unstaged = change[1]
      next if staged == "D" || unstaged == "D"

      path = change.split.last
      result << path if yield(path)
    end
    result
  end
end
