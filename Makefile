# Utility for building the Jekyll-based website.
BUNDLER := bundle

# Contents of the public website.
SITE_DIR := docs


ERR_MSG = Error: cannot find '$(BUNDLER)' in path

# Function to check whether `$(BUNDLER)` is in `PATH`.
bundler_chk =                              \
        @which $(BUNDLER) > /dev/null   || \
                (echo "$(ERR_MSG)" >& 2 && \
					exit 1)


.PHONY: build compile clean rebuild serve


build: compile

compile:
	$(call bundler_chk)
	@$(BUNDLER) exec jekyll build

clean:
	@rm -rf $(SITE_DIR)

# The `pipe` forces order.
rebuild: clean | build

serve: build
	@$(BUNDLER) exec jekyll serve
