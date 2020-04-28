
def get_input
  print "\nstart row"
  row = gets.chomp.to_i
  p "start col"
  col = 4 #gets.chomp.to_i
  p "finish row"
  finish_row = gets.chomp.to_i
  p "finish col"
  finish_col = 3 #gets.chomp.to_i
  return [row, col], [finish_row, finish_col]
end

