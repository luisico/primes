require_relative '../lib/prime.rb'

RSpec.describe Prime do
  before(:each) { Prime.class_variable_set :@@primes, []}

  context "#initialize" do
    it "should save the candidate number" do
      expect(Prime.new(13).number).to eq 13
    end

    it "should fill all primes" do
      expect_any_instance_of(Prime).to receive(:fill_primes)
      Prime.new(5)
    end

    it "should raise error without an argument" do
      expect{Prime.new}.to raise_error ArgumentError
    end

    it "should raise error with more than one argument" do
      expect{Prime.new(2, 3)}.to raise_error ArgumentError
    end

    it "should raise error for non integer arguments" do
      [nil, 'a', 14.1].each do |arg|
        expect{Prime.new(arg)}.to raise_error ArgumentError
      end
    end
  end

  context "#prime?" do
    it "should return true for prime candidate numbers" do
      number = Prime.new(5)
      expect(number.prime?).to be true
    end

    it "should return false for non-prime candidate numbers" do
      number = Prime.new(6)
      expect(number.prime?).to be false
    end
  end

  context "#fill_primes" do
    it "should fill primes up to the candidate number" do
      Prime.new(18)
      expect(Prime.primes).to eq [2, 3, 5, 7, 11, 13, 17]
    end

    it "should not include repeated primes" do
      Prime.new(2)
      expect(Prime.primes).to eq [2]
      Prime.new(3)
      expect(Prime.primes).to eq [2, 3]
    end
  end

  context "#primality" do
    it "should return false for number lower than 2" do
      number = Prime.new(1)
      [-1, 0, 1].each do |arg|
        expect(number.send(:primality, arg)).to be false
      end
    end

    it "should skip modulo calculation if candidate number is known to be a prime" do
      number = Prime.new(7)
      expect(Prime.primes).not_to receive(:any?)
      number.send(:primality, 5)
    end

    it "should do modulo calculation if candidate number is not known to be a prime" do
      number = Prime.new(5)
      expect(Prime.primes).to receive(:any?)
      number.send(:primality, 7)
    end

    it "should raise an error if candidate number is unspecified" do
      number = Prime.new(1)
      expect{number.send(:primality)}.to raise_error ArgumentError
    end

    it "should raise an error if candidate number is not an integer" do
      number = Prime.new(1)
      [nil, '', 'a', 14.1].each do |arg|
        expect{number.send(:primality, arg)}.to raise_error ArgumentError
      end
    end
  end

  context "number attribute reader" do
    it "should be able to get the number prime number" do
      expect(Prime.new(13).number).to eq 13
    end
  end
end
