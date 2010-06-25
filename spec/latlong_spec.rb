require 'spec_helper'

describe LatLong do
  subject { LatLong }
  
  its(:methods) { should include("to_xy") }
  
  describe ".to_xy" do
    
    context_name = nil
    Dir[File.dirname(__FILE__) + '/fixtures/*.txt'].each do |fixture|
    
      context File.basename(fixture).gsub('.txt', '').gsub('_', ' ') do
        File.readlines(fixture).each do |line|
          parts = line.split(/\s+/)
          input, x, y = parts[0] + " " + parts[1], parts[2].to_f, parts[3].to_f
          it "#{input} should become [#{x}, #{y}]" do
            LatLong.to_xy(input).should == [x, y]
          end
        end
      end # Context
      
    end
    
  end

end