```sh
	git clone git@github.com:panjan/job_processor.git
	cd job_processor
	asdf install # to install elixir version from .tool-versions
	mix setup
	mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running Tests

```sh
MIX_ENV=test mix test
```
