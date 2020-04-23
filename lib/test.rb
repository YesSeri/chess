require_relative 'rules'
include Rules
class A
  def initialize
    test
  end
end
test = A.new
