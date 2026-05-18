.PHONY: build test lint install clean build-mcp install-mcp build-all printing-press-generate printing-press-version printing-press-publish-validate printing-press-publish-package catalog

# Printing Press commands
PRINTING_PRESS := /Users/daniele/go/bin/printing-press
SPEC_FILE := openapi-jobs.yaml
CLI_NAME := twilio-jobs-pp-cli
OUTPUT_DIR := .
PUBLISH_CATEGORY := jobs
PUBLISH_STAGING := /tmp/twilio-jobs-pp-cli-staging

printing-press-version:
	@$(PRINTING_PRESS) --version

printing-press-generate:
	@echo "Generating CLI from OpenAPI spec with Printing Press..."
	$(PRINTING_PRESS) generate --spec $(SPEC_FILE) --name $(CLI_NAME) --output $(OUTPUT_DIR) --force

printing-press-regen: clean printing-press-generate
	@echo "Regenerated CLI from spec"

printing-press-verify:
	@echo "Running verification gates..."
	$(PRINTING_PRESS) scorecard --dir . --spec $(SPEC_FILE)
	$(PRINTING_PRESS) dogfood --dir . --spec $(SPEC_FILE)

printing-press-docs:
	@echo "Printing Press CLI generation workflow:"
	@echo ""
	@echo "make printing-press-version          - Show installed Printing Press version"
	@echo "make printing-press-generate         - Generate CLI from OpenAPI spec"
	@echo "make printing-press-regen            - Clean & regenerate CLI"
	@echo "make printing-press-verify           - Run quality verification"
	@echo "make printing-press-publish-validate - Validate CLI is ready for publishing"
	@echo "make printing-press-publish-package  - Package CLI into staging dir for publishing"
	@echo "make catalog                         - Browse the embedded API catalog"

printing-press-publish-validate:
	@echo "Validating CLI for publishing..."
	$(PRINTING_PRESS) publish validate --dir $(OUTPUT_DIR)

printing-press-publish-package:
	@echo "Packaging CLI into staging dir $(PUBLISH_STAGING)..."
	$(PRINTING_PRESS) publish package --dir $(OUTPUT_DIR) --category $(PUBLISH_CATEGORY) --target $(PUBLISH_STAGING)
	@echo "Staged to $(PUBLISH_STAGING)"

catalog:
	$(PRINTING_PRESS) catalog list

# Build targets
build:
	go build -o bin/twilio-jobs-pp-cli-pp-cli ./cmd/twilio-jobs-pp-cli-pp-cli

test:
	go test ./...

lint:
	golangci-lint run

install:
	go install ./cmd/twilio-jobs-pp-cli-pp-cli

clean:
	rm -rf bin/

build-mcp:
	go build -o bin/twilio-jobs-pp-cli-pp-mcp ./cmd/twilio-jobs-pp-cli-pp-mcp

install-mcp:
	go install ./cmd/twilio-jobs-pp-cli-pp-mcp

build-all: build build-mcp
