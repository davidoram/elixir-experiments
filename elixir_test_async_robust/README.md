# ElixirTestAsyncRobust

Test async API calls, where response might fail or timeout

```
mix escript.build
./elixir_test_async
```

Run the [slow server](https://github.com/davidoram/slow-server) as our test API backend

Show:
- Change timeouts on Poison -> detect and continue
- Swap code to raise an exception -> crash
- Exceed `await_many` timeout -> crash
