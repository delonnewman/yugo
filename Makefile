PROJECT_NAME          := Yugo
PROJECT_ROOT          := $(realpath $(dir $(firstword $(MAKEFILE_LIST))))
SERVICE_NAME          := $(shell echo $(PROJECT_NAME) | tr '[:upper:]' '[:lower:]')
ROOT_REGISTRY_PATH    := uh-registry.health.unm.edu/devgroup
PROJECT_REGISTRY_PATH := $(ROOT_REGISTRY_PATH)/$(SERVICE_NAME)
GIT_COMMIT            := $(shell git rev-parse --short=8 HEAD)
REPLICAS              := 1
DOCKER_FILE           := $(PROJECT_ROOT)/Dockerfile
RUBY_VERSION          := jruby-9.2.6.0
BUNDLER_VERSION       := 2.1.4
RVM_PATH              := $(HOME)/.rvm
RVM_BIN_PATH          := $(RVM_PATH)/bin
RVM_BIN               := $(RVM_BIN_PATH)/rvm
RVM_INSTALL_TARGET    := $(RUBY_VERSION)
RUBY_INSTALL_PATH     := $(RVM_PATH)/rubies/$(RVM_INSTALL_TARGET)
RUBY_BIN_PATH         := $(RUBY_INSTALL_PATH)/bin
BUNDLER_BIN           := $(RUBY_BIN_PATH)/bundle
BREW_PATH             := /usr/local
BREW_BIN_PATH         := $(BREW_PATH)/bin
BREW_BIN              := $(BREW_BIN_PATH)/brew
CURL_BIN              := /usr/bin/curl
GPG_BIN               := $(BREW_BIN_PATH)/gpg
BUNDLER_LOCK_FILE     := $(PROJECT_ROOT)/Gemfile.lock
JAVA_VERSION          := 1.8.0
export JAVA_HOME      := $(shell /usr/libexec/java_home -v $(JAVA_VERSION))

PHONY: all test help deps repl clean

all: deps

setup: $(RUBY_INSTALL_PATH) $(BUNDLER_BIN)

deps: .make-deps

.make-deps: $(BUNDLER_LOCK_FILE)
	@touch .make-deps

test: deps

repl: deps
	pry -r ./lib/yugo.rb

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

$(BREW_BIN):
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

$(GPG_BIN):
	$(BREW_BIN) install gpg2

$(RVM_BIN): $(GPG_BIN)
	$(GPG_BIN) --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
		$(CURL_BIN) -sSL https://get.rvm.io | bash -s stable

$(RUBY_INSTALL_PATH): $(RVM_BIN)
	$(RVM_BIN) install "$(RVM_INSTALL_TARGET)"

$(BUNDLER_LOCK_FILE):
	bundle install && touch $(BUNDLER_LOCK_FILE)

$(BUNDLER_BIN):
	gem install bundler -v $(BUNDLER_VERSION)
