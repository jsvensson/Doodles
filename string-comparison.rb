def secure_compare(a, b)
  if a.length == b.length
    result = 0
    for i in 0..(a.length - 1)
      result |= a[i] ^ b[i]
    end
    result == 0
  else
    false
  end
end
