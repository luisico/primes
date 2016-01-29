class Prime
  attr_reader :number

  # Keep track of known primes
  @@primes = []
  class << self
    def primes
      @@primes
    end
  end

  def initialize(number)
    @number = number

    raise(ArgumentError, 'Number must be an integer') unless number.is_a?(Integer)
    fill_primes
  end

  def prime?
    Prime.primes.include?(number)
  end

  private

  def fill_primes
    # Fill list of primes up to required candidate number
    last_prime = Prime.primes.last || 2
    if last_prime <= number
      (last_prime..number).to_a.each { |n| Prime.primes << n if primality(n)}
    end

    # Clean up list of primes
    Prime.primes.uniq!
  end

  def primality(candidate=nil)
    # Let's treat non integer as non-prime
    raise(ArgumentError, 'Candidate must be an integer') unless candidate.is_a?(Integer)

    # Known fact: first prime number is 2
    return false if candidate < 2

    # Skip already known primes
    return true if Prime.primes.include?(candidate)

    # Candidate is prime if it is not divisible by known primes
    !Prime.primes.any? { |prime| candidate.modulo(prime) == 0 }
  end
end
