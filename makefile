.DEFAULT_GOAL := help
BUNDLE=$(if $(rbenv > /dev/null), rbenv exec bundle, bundle)
FASTLANE=$(BUNDLE) exec fastlane
COCOAPODS=$(BUNDLE) exec pod

# Setup
setup: ## setup project with Tuist and Cocoapods
	make install_tuist
	tuist generate
# $(COCOAPODS) install

install: ## install required dependencies
# make install_bundle
# $(COCOAPODS) install --repo-update

install_bundle: ## install gems
	$(BUNDLE) install

download_tuist:
	curl -Ls https://install.tuist.io | bash

install_tuist:
	which tuist || make download_tuist

secrets: ## generate secrets for sensitive data
	sh ./scripts/sourcery.sh

# Wipes
xcode_wipe: ## delete all xcode cached outputs, kill and reset all simulators
	-rm -rf ~/Library/Developer/Xcode/{DerivedData,Archives,Products}
	make reset_simulator
	
reset_simulator: ## reset all iOS Simulators
	-osascript -e 'tell application "Simulator" to quit'
	-xcrun simctl shutdown all
	-xcrun simctl erase all

clean_workspace: ## clean projects
	rm -r SampleApp/SampleApp.xcodeproj
	rm -r Wellness/Wellness.xcodeproj
	rm -r Wellness.xcworkspace

# Tests
test: ## run unit tests
	$(FASTLANE) test_module

sanity_check: ## run sanity check
	$(FASTLANE) sanity_check

coverage: ## Output coverage file
	$(FASTLANE) check_module_coverage

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'