class LatLong
  def self.to_xy(input)
    x, y = nil
    
    case input
    when /([+-]?\d+[.]\d+)\s+([+-]?\d+[.]\d+)/
      x, y = $2, $1
    end
    
    [x.to_f, y.to_f]
  end
end