# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Emails (Base64 encoded, just so we don't push them in
#   clear text to GitHub

require 'base64'

emails = [
  "cGVkZXIua29uZ2VsZkBuZXRsaWdodC5jb20=\n",
  "c2ViYXN0aWFuLnNjaG9sZEBuZXRsaWdodC5jb20=\n",
  "YW5kZXJzLmxpbmRlbkBuZXRsaWdodC5jb20=\n",
  "Yml0Y291cG9uQGxpc3Quc3R1ZC5udG51Lm5v\n",
  "YWduZXRoZXMwcmFhQGdtYWlsLmNvbQ==\n"
]

emails.each do |e|
  u = User.new(email: Base64.decode64(e))
  u.password = 'bitcoupon'
  u.generate_keys
  u.save
end
