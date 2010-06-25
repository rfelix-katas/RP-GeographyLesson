class LatLong
  DECIMAL = /\d+[.]\d+/
  DIRECTION = /[NSEW]/
  INTEGER = /\d+/
  
  @@directions = {
    nil  => ['+', '+'],
    "NE" => ['+', '+'],
    "NW" => ['-', '+'],
    "SE" => ['+', '-'],
    "SW" => ['-', '-'],
  }
  
  def self.to_xy(input)
    x, y = nil
    
    case input
    when /([+-]?#{DECIMAL})\s+([+-]?#{DECIMAL})/
      x, y = $2, $1
    when /(#{DECIMAL})\s+(#{DIRECTION})\s+(#{DECIMAL})\s+(#{DIRECTION})/
      x, y = "#{@@directions[$2 + $4][0]}#{$3}", "#{@@directions[$2 + $4][1]}#{$1}"
    when /(#{DIRECTION})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{DECIMAL})/
      x, y = "#{@@directions[$1 + $3][0]}#{$4}", "#{@@directions[$1 + $3][1]}#{$2}"
    when /(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})/
      x, y = $4.to_f, $1.to_f
      x += min_to_deg($5.to_f)
      y += min_to_deg($2.to_f)
      x, y = "#{@@directions[$3 + $6][0]}#{x}", "#{@@directions[$3 + $6][1]}#{y}"
    when /(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})/
      x, y = $5.to_f, $2.to_f
      x += min_to_deg($6.to_f)
      y += min_to_deg($3.to_f)
      x, y = "#{@@directions[$1 + $4][0]}#{x}", "#{@@directions[$1 + $4][1]}#{y}"
    when /([+-]?#{INTEGER})\s+(#{DECIMAL})\s+([+-]?#{INTEGER})\s+(#{DECIMAL})/
      x, y = $3.to_f, $1.to_f
      x += (x < 0 ? -1 : 1) * min_to_deg($4.to_f)
      y += (y < 0 ? -1 : 1) * min_to_deg($2.to_f)
    else
      raise "Input Format Not Supported"
    end
    
    [x.to_f, y.to_f]
  end
  
  def self.min_to_deg(min)
    min / 60.0
  end
end