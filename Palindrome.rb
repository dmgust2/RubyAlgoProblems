# TestDome Palindrome problem

module Palindrome

=begin
  def self.is_palindrome(word)
    # Easy: simply use the string.reverse call
    if word.casecmp(word.reverse) == 0
      return true
    else
      return false
    end
  end
=end

  def self.is_palindrome(word)
    reversed_string = ''
    i = 0
    while i < word.length
      reversed_string = word[i] + reversed_string
      i += 1
    end

    if word.casecmp(reversed_string) == 0
      return true
    else
      return false
    end
  end

end

# Test 1
puts Palindrome.is_palindrome('Deleveled')

# Test 2
puts Palindrome.is_palindrome('abc')

# Test 3
puts Palindrome.is_palindrome('aba')
