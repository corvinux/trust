set -ex

# TODO This is the "test phase", tweak it as you see fit
main() {
    if [ ! -f Cargo.lock ]; then
        cargo generate-lockfile
    fi

    cross build --target $TARGET
    cross build --target $TARGET --release

    if [ -z $DISABLE_TESTS ]; then
        cross test --target $TARGET
        cross test --target $TARGET --release

        cross run --target $TARGET
        cross run --target $TARGET --release
    fi
}

# we don't run the "test phase" when doing deploys
if [ -z $TRAVIS_TAG ]; then
    main
fi
