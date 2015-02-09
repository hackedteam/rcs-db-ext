require 'test_helper'
require 'rvincenty'


class RVincentyTest < Test::Unit::TestCase
  # positions are from Wikipedia
  BAIKONUR_COSMODROME               = [45.965, 63.305         ]
  KENNEDY_SPACE_CENTER              = [28.585, -80.651        ]
  JIUQUAN_SATELLITE_LAUNCH_CENTER   = [40.957778, 100.291667  ]
  SAN_MARCO_PLATFORM                = [-2.938333, 40.2125     ]
  SOUTH_POLE                        = [-90, -0                ]
  NORTH_POLE                        = [90, -0                 ]
  AMUNDSEN_SCOTT_SOUTH_POLE_STATION = [-90, -139.266667       ]

  # distance values are from http://www.movable-type.co.uk/scripts/latlong-vincenty.html
  DISTANCES = [
    [BAIKONUR_COSMODROME, KENNEDY_SPACE_CENTER, 10_986_163.684],
    [SOUTH_POLE, JIUQUAN_SATELLITE_LAUNCH_CENTER, 14_537_850.120],
    [SOUTH_POLE, AMUNDSEN_SCOTT_SOUTH_POLE_STATION, 0],
    [SOUTH_POLE, NORTH_POLE, 20_003_931.459],
    [NORTH_POLE, SOUTH_POLE, 20_003_931.459],
    [BAIKONUR_COSMODROME, JIUQUAN_SATELLITE_LAUNCH_CENTER, 3_016_381.278],
    [AMUNDSEN_SCOTT_SOUTH_POLE_STATION, SAN_MARCO_PLATFORM, 9_677_058.827],
    [AMUNDSEN_SCOTT_SOUTH_POLE_STATION, AMUNDSEN_SCOTT_SOUTH_POLE_STATION, 0],
    [JIUQUAN_SATELLITE_LAUNCH_CENTER, BAIKONUR_COSMODROME, 3016381.278],
  ]

  def test_vincenty
    DISTANCES.each do |a, b, distance|
      calc_distance = RVincenty.distance(a,b)

      assert_in_delta distance, calc_distance, 0.0005, "from: %s to: %s" % [a.inspect, b.inspect]
    end
  end
  
  def test_readme_example
    point_a = 45.965, 63.305    # Baikonur Cosmodrome
    point_b = 28.585, -80.651   # John F. Kennedy Space Center
    
    distance = RVincenty.distance(point_a, point_b)
    
    assert_in_delta distance, 10_986_163.684, 0.0005
    
    out = "Distance between %s and %s is %f km" % [point_a.inspect, point_b.inspect, distance / 1000]
  end

end
