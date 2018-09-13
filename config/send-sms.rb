require("bundler")
Bundler.require()

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']

@client = Twilio::REST::Client.new(account_sid, auth_token)

@client.messages.create(
  to: "+12104008165",
  from: "+18306421354",
  body: "Thank you. WellFence is processing your request. We will reach out to you shortly. Tune to 87.9 to hear an important safety broadcast."
)
