# Utility for building the Jekyll-based website.
BUNDLER := bundle

# Contents of the public website.
SITE_DIR := _site

# Excludes.
EXCLUDES := $(SITE_DIR)/Makefile $(SITE_DIR)/.envrc


ERR_MSG = Error: cannot find '$(BUNDLER)' in path

# Function to check whether `$(BUNDLER)` is in `PATH`.
bundler_chk =                              \
        @which $(BUNDLER) > /dev/null   || \
                (echo "$(ERR_MSG)" >& 2 && \
					exit 1)


.PHONY: build compile clean wipe serve


# The `pipe` forces order.
build: | compile clean

compile:
	$(call bundler_chk)
	@$(BUNDLER) exec jekyll build

clean:
	@rm -f $(EXCLUDES)

serve: build
	@$(BUNDLER) exec jekyll serve

wipe:
	@rm -rf $(SITE_DIR)
