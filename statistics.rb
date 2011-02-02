def fact(n)
  (1..n).inject(:*)
end

n = 5
k = 3

puts fact(n) / (fact(k) * fact(n-k))