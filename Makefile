PHONY: test

export JAVA_HOME := $(shell /usr/libexec/java_home -v 1.8.0)

test:
	rspec

help:
	@echo JAVA_HOME: $(JAVA_HOME)
