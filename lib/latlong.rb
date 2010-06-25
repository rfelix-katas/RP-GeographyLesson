class LatLong
  DECIMAL = /\d+[.]\d+/
  DIRECTION = /[NSEW]/
  INTEGER = /\d+/
  
  @@directions = {
    "NE" => ['+', '+'],
    "NW" => ['-', '+'],
    "SE" => ['+', '-'],
    "SW" => ['-', '-'],
  }
  
  def self.to_xy(input)
    x, y = case input
    when /([+-]?#{DECIMAL})\s+([+-]?#{DECIMAL})/
      process_degrees(
        :y => { :degrees => $1 },
        :x => { :degrees => $2 }
      )
    when /(#{DECIMAL})\s+(#{DIRECTION})\s+(#{DECIMAL})\s+(#{DIRECTION})/
      process_degrees(
        :y => { :direction => $2,  :degrees => $1 },
        :x => { :direction => $4,  :degrees => $3 }
      )
    when /(#{DIRECTION})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{DECIMAL})/
      process_degrees(
        :y => { :direction => $1,  :degrees => $2 },
        :x => { :direction => $3,  :degrees => $4 }
      )
    when /(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})/
      process_degrees(
        :y => {
          :degrees => $1,
          :min => $2,
          :direction => $3
        },
        :x => {
          :degrees => $4,
          :min => $5,
          :direction => $6
        }
      )
    when /(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{INTEGER})\s+(#{DECIMAL})/
      process_degrees(
        :y => {
          :direction => $1,
          :degrees => $2,
          :min => $3
        },
        :x => {
          :direction => $4,
          :degrees => $5,
          :min => $6
        }
      )
    when /([+-]?#{INTEGER})\s+(#{DECIMAL})\s+([+-]?#{INTEGER})\s+(#{DECIMAL})/
      process_degrees(
        :y => {
          :degrees => $1,
          :min => $2
        },
        :x => {
          :degrees => $3,
          :min => $4
        }
      )
    when /(#{INTEGER})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})\s+(#{INTEGER})\s+(#{INTEGER})\s+(#{DECIMAL})\s+(#{DIRECTION})/
      process_degrees(
        :y => {
          :degrees => $1,
          :min => $2,
          :sec => $3,
          :direction => $4
        },
        :x => {
          :degrees => $5,
          :min => $6,
          :sec => $7,
          :direction => $8
        }
      )
    else
      raise "Input Format Not Supported"
    end
    
    [x.to_f, y.to_f]
  end
  
private  

  def self.min_to_deg(min)
    min / 60.0
  end
  
  def self.sec_to_min(sec)
    sec.to_f / 60.0
  end
  
  def self.process_degrees(data)
    default = { 
      :x => {:direction => nil, :min => 0, :sec => 0}, :y => {:sec => 0}
    }
    default[:y] = default[:x].dup
    data.merge!(default) { |key, v1, v2| v1 }
    
    x, y = data[:x][:degrees].to_f, data[:y][:degrees].to_f

    x += (x < 0 ? -1 : 1) * min_to_deg(data[:x][:min].to_f + sec_to_min(data[:x][:sec]))
    y += (y < 0 ? -1 : 1) * min_to_deg(data[:y][:min].to_f + sec_to_min(data[:y][:sec]))

    unless data[:y][:direction].nil?
      direc_key = data[:y][:direction] + data[:x][:direction]
      x_sign = @@directions[direc_key][0]
      y_sign = @@directions[direc_key][1]
    end
    
    ["#{x_sign}#{x}", "#{y_sign}#{y}"]
  end
end