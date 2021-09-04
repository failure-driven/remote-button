FactoryBot.define do
  factory :button do
    email { "m@m.m" }
    site { "site.com" }
    external_reference { SecureRandom.hex(6).upcase.scan(/../).join(":") }
    id { SecureRandom.uuid }
  end
end
