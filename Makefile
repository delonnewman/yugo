PROJECT_NAME    := Yugo
JAVA_VERSION    := 1.8.0
RUBY_PATH       := vendor/jruby-9.2.9.0
RUBY_BIN        := $(RUBY_PATH)/bin/jruby
GEM_BIN         := $(RUBY_BIN) -S gem
BUNDLER_PATH    := $(RUBY_PATH)/bin/bundle
BUNDLER_BIN     := $(RUBY_BIN) -S bundle
BUNDLER_VERSION := 2.1.4
PRY_BIN         := $(RUBY_BIN) -S pry

PHONY: all test help deps repl clean

export JAVA_HOME := $(shell /usr/libexec/java_home -v $(JAVA_VERSION))

all: deps

$(BUNDLER_PATH):
	$(GEM_BIN) install bundler --version $(BUNDLER_VERSION) --install-dir $(RUBY_PATH)

deps: .make-deps

.make-deps: $(BUNDLER_PATH)
	$(BUNDLER_BIN) install
	@touch .make-deps

test: deps

repl: deps
	$(PRY_BIN) -r ./lib/yugo.rb -r ./spec/generators.rb

clean:
	rm -rf .make-deps

help:
	@echo $(PROJECT_NAME) Makefile
	@echo
	@echo "Bundler Version: $(BUNDLER_VERSION)"
	@echo "Java Version: $(JAVA_VERSION)"
