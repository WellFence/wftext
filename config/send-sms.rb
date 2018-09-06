require("bundler")
Bundler.require()

account_sid = "AC56b53d6358ccfd93aa9769cd04ac9f2d"
auth_token = "29c2ba7b3e7d156ede52b53373dbdecd"

@client = Twilio::REST::Client.new(account_sid, auth_token)

@client.messages.create(
  to: "+12104008165",
  from: "+18306421354",
  body: "Thank you. WellFence is processing your request. We will reach out to you shortly. Tune to 87.9 to hear an important safety broadcast."
)
