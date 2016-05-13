# all of these extensions make the logic in the Board#winner? and Board#draw?
# methods much easier.
class Array
  def all_empty?
    self.all? { |element| element.to_s.empty? }
  end

  def all_same?
    self.all? { |element| element == self[0] }
  end

  def any_empty?
    self.any? { |element| element.to_s.empty? }
  end

  def none_empty?
    !any_empty?
  end
end
