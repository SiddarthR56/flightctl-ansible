TEST_ARGS ?= ""
PYTHON_VERSION ?= `python -c 'import platform; print(".".join(platform.python_version_tuple()[0:2]))'`

unit-test:
	ansible-test units --docker -v --color --python $(PYTHON_VERSION) $(?TEST_ARGS)

integration-test: write-integration-config
	ansible-test integration --docker --diff --color --python $(PYTHON_VERSION) -v $(?TEST_ARGS)

sanity-test:
	ansible-test sanity --docker -v --color --python $(PYTHON_VERSION) $(?TEST_ARGS)

write-integration-config:
	@service_addr="$(shell cat ~/.config/flightctl/client.yaml | grep server | awk '{print $$2}')"; \
    echo "flightctl_host: $$service_addr" > ./tests/integration/integration_config.yml
