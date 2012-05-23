
module GeoFence

  # Adapted from a wonderful explanation of this algorithm in C code at
  # http://alienryderflex.com/polygon_area/
  def self.calculate_area(points)
    area = 0
    j = points.count - 1
    (points.count).times do |i|
      area += (points[j][0] + points[i][0]) * (points[j][1] - points[i][1])
      j = i
    end
    area * 0.5
  end

end
