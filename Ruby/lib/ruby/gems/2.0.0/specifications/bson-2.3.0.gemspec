# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bson"
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Brock", "Durran Jordan", "Brandon Black", "Emily Stolfo", "Gary Murakami"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDfDCCAmSgAwIBAgIBATANBgkqhkiG9w0BAQUFADBCMRQwEgYDVQQDDAtkcml2\nZXItcnVieTEVMBMGCgmSJomT8ixkARkWBTEwZ2VuMRMwEQYKCZImiZPyLGQBGRYD\nY29tMB4XDTE0MDIxOTE1MTEyNloXDTE1MDIxOTE1MTEyNlowQjEUMBIGA1UEAwwL\nZHJpdmVyLXJ1YnkxFTATBgoJkiaJk/IsZAEZFgUxMGdlbjETMBEGCgmSJomT8ixk\nARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANFdSAa8fRm1\nbAM9za6Z0fAH4g02bqM1NGnw8zJQrE/PFrFfY6IFCT2AsLfOwr1maVm7iU1+kdVI\nIQ+iI/9+E+ArJ+rbGV3dDPQ+SLl3mLT+vXjfjcxMqI2IW6UuVtt2U3Rxd4QU0kdT\nJxmcPYs5fDN6BgYc6XXgUjy3m+Kwha2pGctdciUOwEfOZ4RmNRlEZKCMLRHdFP8j\n4WTnJSGfXDiuoXICJb5yOPOZPuaapPSNXp93QkUdsqdKC32I+KMpKKYGBQ6yisfA\n5MyVPPCzLR1lP5qXVGJPnOqUAkvEUfCahg7EP9tI20qxiXrR6TSEraYhIFXL0EGY\nu8KAcPHm5KkCAwEAAaN9MHswCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0O\nBBYEFFt3WbF+9JpUjAoj62cQBgNb8HzXMCAGA1UdEQQZMBeBFWRyaXZlci1ydWJ5\nQDEwZ2VuLmNvbTAgBgNVHRIEGTAXgRVkcml2ZXItcnVieUAxMGdlbi5jb20wDQYJ\nKoZIhvcNAQEFBQADggEBALGvdxHF+CnH6QO4PeIce3S8EHuHsYiGLk4sWgNGZkjD\nV3C4XjlI8rQZxalwQwcauacOGj9x94flWUXruEF7+rjUtig7OIrQK2+uVg86vl8r\nxy1n2s1d31KsuazEVExe5o19tnVbI9+30P9qPkS+NgaellXpj5c5qnJUGn5BJtzo\n3D001zXpVnuZvCcE/A4fQ+BEM0zm0oOmA/gWIAFrufOL9oYg1881dRZ+kQytF/9c\nJrZM8w8wGbIOeLtoQqa7HB/jOYbTahH7KMNh2LHAbOR93hNIJxVRa4iwxiMQ75tN\n9WUIAJ4AEtjwRg1Bz0OwDo3aucPCBpx77+/FWhv7JYY=\n-----END CERTIFICATE-----\n"]
  s.date = "2014-06-02"
  s.description = "A full featured BSON specification implementation, in Ruby"
  s.email = ["mongodb-dev@googlegroups.com"]
  s.extensions = ["ext/bson/extconf.rb"]
  s.files = ["ext/bson/extconf.rb"]
  s.homepage = "http://bsonspec.org"
  s.licenses = ["Apache License Version 2.0"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubyforge_project = "bson"
  s.rubygems_version = "2.0.14"
  s.summary = "Ruby Implementation of the BSON specification"
end
