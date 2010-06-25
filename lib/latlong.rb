class LatLong
  NUMBER = /\d+[.]\d+/
  DIRECTION = /[NSEW]/
  
  @@directions = {
    "NE" => ['+', '+'],
    "NW" => ['-', '+'],
    "SE" => ['+', '-'],
    "SW" => ['-', '-'],
  }
  
  def self.to_xy(input)
    x, y = nil
    
    case input
    when /([+-]?#{NUMBER})\s+([+-]?#{NUMBER})/
      x, y = $2, $1
    when /(#{NUMBER})\s+(#{DIRECTION})\s+(#{NUMBER})\s+(#{DIRECTION})/
      x, y = "#{@@directions[$2 + $4][0]}#{$3}", "#{@@directions[$2 + $4][1]}#{$1}"
    when /(#{DIRECTION})\s+(#{NUMBER})\s+(#{DIRECTION})\s+(#{NUMBER})/
      x, y = "#{@@directions[$1 + $3][0]}#{$4}", "#{@@directions[$1 + $3][1]}#{$2}"      
    else
      raise "Input Format Not Supported"
    end
    
    [x.to_f, y.to_f]
  end
end