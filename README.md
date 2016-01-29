# Primes multiplication

A small command line app to create a multiplication table of prime numbers

## Installation

Clone or download the code to a local directory and bundle. This should install all dependencies. You can skip this step if you don't plan on running the spec suite (see below).
```
bundle
```

## Running

Can't get simpler than this:
```
bin/app.rb
```

Oh, you want options? Well, you can change the number of primes to use and/or change the width of the cells in the printout:
```
Usage: app [options]
    -m, --max INTEGER                Maximum prime numbers
    -w, --width INTEGER              Cell width
```

## Testing

This isn't much complicated either, assuming you already got the dependencies in place (see above):
```
rspec
```

## Author

Luis Gracia (lgraval@gmail.com)
