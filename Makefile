PROJECT_NAME    := Yugo
JAVA_VERSION    := 1.8.0
RUBY_VERSION    := jruby-9.2.9.0
RUBY_PATH       := vendor/$(RUBY_VERSION)
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
	@echo "Ruby Version: $(RUBY_VERSION)"
	@echo "Bundler Version: $(BUNDLER_VERSION)"
	@echo "Java Version: $(JAVA_VERSION)"
	@echo
	@echo "Tasks:"
	@echo "  all - build project"
	@echo " deps - pull dependencies"
	@echo " test - run tests"
	@echo " repl - load a project REPL/console"
	@echo "clean - remove touch files"
	@echo " help - display this message"
