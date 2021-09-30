# Calc

## Compile the app

```
# Build
mix deps.get --only prod
MIX_ENV=prod mix compile

# Run
PORT=4000 MIX_ENV=prod mix phx.server
```


Test

- ok `curl http://localhost:4000/api/+/1/1`
- fail `curl http://localhost:4000/api/div/100/0`

## Load test tool

[Baton](https://github.com/americanexpress/baton), installed via  `go get -u github.com/americanexpress/baton`.

Run `baton -z test.baton -c 25 -r 100000` to stress test the API

- 25 concurrent requests
- 100,000 requests total

Will it keep running?

`baton -u http://localhost:4000/api/div/100/0 -r 100000 -c 25`
## Questions to be answered

- How should I code for problems?
  - Do I add a bunch of defensive code?
- What happens when it crashes?
  - Can I log the crash
  - Can I return an API response?
