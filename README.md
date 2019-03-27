# Hashematics

[![Gem Version](https://badge.fury.io/rb/hashematics.svg)](https://badge.fury.io/rb/hashematics) [![Build Status](https://travis-ci.org/bluemarblepayroll/hashematics.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/hashematics) [![Maintainability](https://api.codeclimate.com/v1/badges/a171325c301e58eb4fb0/maintainability)](https://codeclimate.com/github/bluemarblepayroll/hashematics/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/a171325c301e58eb4fb0/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/hashematics/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

-- Under Construction. --

## Installation

To install through Rubygems:

````
gem install install hashematics
````

You can also add this to your Gemfile:

````
bundle add hashematics
````

## Examples

-- Under Construction. --

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check hashematics.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/hashematics.git)
4. Navigate to the root folder (cd hashematics)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/hashematics/version.rb``` using [semantic versioning](https://semver.org/)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Build the project locally: `gem build hashematics`
7. Publish package to RubyGems: `gem push hashematics-X.gem` where X is the version to push
8. Tag master with new version: `git tag <version>`
9. Push tags remotely: `git push origin --tags`

## License

This project is MIT Licensed.
