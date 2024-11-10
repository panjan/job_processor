## Setting Up The Server

```sh
	git clone git@github.com:panjan/job_processor.git
	cd job_processor
	asdf install # to install Elixir/Erlang version from .tool-versions
	mix setup
	mix phx.server
```

## Usage

```sh
	# call /api/job to get the task execution order
	curl -X POST -H "Content-Type: application/json" -d "@test/support/example_request.json" http://localhost:4000/api/job
	# {"tasks":[{"command":"touch /tmp/file1","name":"task-1"},{"command":"echo 'Hello World!' > /tmp/file1","name":"task-3"},{"command":"cat /tmp/file1","name":"task-2"},{"command":"rm /tmp/file1","name":"task-4"}]}

	# call /api/job_script to get the bash script representation directly
	curl -X POST -H "Content-Type: application/json" -d "@test/support/example_request.json" http://localhost:4000/api/job_script
	# {"script":"#!/usr/bin/env bash\ntouch /tmp/file1\necho 'Hello World!' > /tmp/file1\ncat /tmp/file1\nrm /tmp/file1"}
```

## Running Tests

```sh
MIX_ENV=test mix test
```
