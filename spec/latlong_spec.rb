require 'spec_helper'

describe LatLong do
  subject { LatLong }
  
  its(:methods) { should include("to_xy") }
  
  describe ".to_xy" do
    
    context_name = nil
    Dir[File.dirname(__FILE__) + '/fixtures/*.txt'].each do |fixture|
    
      context "using " + File.basename(fixture).gsub('.txt', '') do
        File.readlines(fixture).each do |line|
          parts = line.split(/\s+/)
          case parts.size
          when 4
            input, x, y = "#{parts[0]} #{parts[1]}", parts[2].to_f, parts[3].to_f
          when 6
            input = "#{parts[0]} #{parts[1]} #{parts[2]} #{parts[3]}"
            x, y  = parts[4].to_f, parts[5].to_f
          end
          it "'#{input}' should become [#{x}, #{y}]" do
            LatLong.to_xy(input).should == [x, y]
          end
        end
      end # Context
      
    end
    
  end

end