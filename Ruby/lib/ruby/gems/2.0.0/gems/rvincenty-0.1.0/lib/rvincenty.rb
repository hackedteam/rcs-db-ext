module RVincenty
  # Calculates the distance between two given points.
  # A point is a two-elmeent array containing the points coordinates (Latitude and Longitutde)
  # experessed as a floating point number.
  def self.distance(point_a, point_b)
    lat1, lon1 = point_a
    lat2, lon2 = point_b

    # WGS-84 ellipsiod
    a = 6378137.0
    b = 6356752.3142
    f = 1.0/298.257223563

    l = deg_to_rad(lon2 - lon1)
    u1 = Math.atan((1.0-f) * Math.tan(deg_to_rad(lat1)));
    u2 = Math.atan((1.0-f) * Math.tan(deg_to_rad(lat2)));

    sinU1 = Math.sin(u1)
    cosU1 = Math.cos(u1)
    sinU2 = Math.sin(u2)
    cosU2 = Math.cos(u2)

    lambda = l

    iterLimit = 100
    lambdaP = nil
    while true
      sinLambda = Math.sin(lambda)
      cosLambda = Math.cos(lambda)

      sinSigma = Math.sqrt((cosU2*sinLambda) * (cosU2*sinLambda) +
        (cosU1*sinU2-sinU1*cosU2*cosLambda) * (cosU1*sinU2-sinU1*cosU2*cosLambda))

      # co-incident points
      return 0 if (sinSigma==0)

      cosSigma = sinU1*sinU2 + cosU1*cosU2*cosLambda;
      sigma = Math.atan2(sinSigma, cosSigma);
      sinalpha = cosU1 * cosU2 * sinLambda / sinSigma;
      cosSqalpha = 1.0 - sinalpha*sinalpha;
      cos2SigmaM = cosSigma - 2.0*sinU1*sinU2/cosSqalpha;
      if cos2SigmaM.nan?
        cos2SigmaM = 0
      end

      c = f/16*cosSqalpha*(4+f*(4-3*cosSqalpha));
      lambdaP = lambda;
      lambda = l + (1.0-c) * f * sinalpha * (sigma + c*sinSigma*(cos2SigmaM+c*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)));
      iterLimit -= 1

      break if (lambda-lambdaP).abs < 1e-12 || iterLimit <= 0
    end

    #formula failed to converge
    return NaN if (iterLimit==0)

    uSq = cosSqalpha * (a*a - b*b) / (b*b);
    va = 1 + uSq/16384.0*(4096.0+uSq*(-768.0+uSq*(320.0-175.0*uSq)))
    vb = uSq/1024.0 * (256.0+uSq*(-128.0+uSq*(74.0-47.0*uSq)))
    deltaSigma = vb*sinSigma*(cos2SigmaM+vb/4.0*(cosSigma*(-1.0+2.0*cos2SigmaM*cos2SigmaM)-
      vb/6*cos2SigmaM*(-3.0+4.0*sinSigma*sinSigma)*(-3+4*cos2SigmaM*cos2SigmaM)))
    s = b*va*(sigma-deltaSigma)

    return s;
  end

  private

  def self.deg_to_rad(deg)
    (Math::PI * deg) / 180
  end
end