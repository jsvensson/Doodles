# Quick, dirty, unsafe factorial
def fact(n)
  (1..n).inject(:*)
end

# Factorial with error checking
def safe_fact(n)
  if n < 1
    raise "argument must be > 0"
  elsif n == 1
    1
  else
    n * safe_fact(n-1)
  end
end

n = 8
k = 7

puts safe_fact(n) / (safe_fact(k) * safe_fact(n-k))
