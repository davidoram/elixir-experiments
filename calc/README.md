# Calc

## Compile the app

Compile via

```
mix deps.get --only prod
MIX_ENV=prod mix compile
```

Then run

`PORT=4000 MIX_ENV=prod mix phx.server`

Test

`curl http://localhost:4000/api/+/1/1`

## Load test tool

[Baton](https://github.com/americanexpress/baton), installed via  `go get -u github.com/americanexpress/baton`.

Run `baton -z test.baton -c 25 -r 100000` to stress test the API

- 25 concurrent requests
- 100,000 requests total


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
