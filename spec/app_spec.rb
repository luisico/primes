require 'aruba/rspec'

RSpec.describe 'Application', type: :aruba do
  context "default options" do
    it "should run correctly" do
      run 'app.rb'
      expect(last_command_started).to have_exit_status 0
    end

    it "should calculate on 10 prime numbers with a cell width of 5 characters" do
      run 'app.rb'
      expect(last_command_started).to have_output an_output_string_matching '    | 2    3    5    7    11   13   17   19   23   29   \n'
    end

    it "should return the correct multiplication table" do
      run 'app.rb'
      expect(last_command_started).to have_output an_output_string_matching '29   | 58   87   145  203  319  377  493  551  667  841  \n'
    end
  end

  context "command line options" do
    it "should report usage" do
      run 'app.rb -h'
      expect(last_command_started).to have_exit_status 0
      expect(last_command_started).to have_output an_output_string_matching 'Usage'
    end

    context "maximum prime number (-m)" do
      it "should be included in usage" do
        run 'app.rb -h'
        expect(last_command_started).to have_exit_status 0
        expect(last_command_started).to have_output an_output_string_matching '--max INTEGER'
      end

      it "should raise errors when argument is not an integer" do
        run 'app.rb -m 14.1'
        expect(last_command_started).to have_exit_status 1
        expect(last_command_started).to have_output an_output_string_matching 'invalid argument'
      end

      it "should change the number of primes to calculate on" do
        run 'app.rb -m 2'
        expect(last_command_started).to have_exit_status 0
        expect(last_command_started).to have_output an_output_string_matching '     | 2    3    \n'
      end
    end

    context "cell width (-w)" do
      it "should be included in usage" do
        run 'app.rb -h'
        expect(last_command_started).to have_exit_status 0
        expect(last_command_started).to have_output an_output_string_matching '--width INTEGER'
      end

      it "should raise errors when argument is not an integer" do
        run 'app.rb -w 14.1'
        expect(last_command_started).to have_exit_status 1
        expect(last_command_started).to have_output an_output_string_matching 'invalid argument'
      end

      it "should change the width of the cells" do
        run 'app.rb -w 7'
        expect(last_command_started).to have_exit_status 0
        expect(last_command_started).to have_output an_output_string_matching '       | 2      3      5      7      11     13     17     19     23     29     \n'
      end
    end
  end
end
