THIS_DIRECTORY := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# The build process has two steps:
# 1. build all packages and copy them into the repo/ subdirectory
# 2. make a pacman repo in there
create-repo: build-packages
	@repo-add -n repo/holo.db.tar.xz repo/*.pkg.tar.xz
	@rm -f repo/holo.db.tar.xz.old
	@ln -sf holo.db repo/holo.files

pull-repo:
	@rsync -vau --delete-delay --progress bethselamin:/data/static-web/repo.holocm.org/archlinux/x86_64/ $(THIS_DIRECTORY)/repo/

push-repo: create-repo
	@rsync -vau --delete-delay --progress $(THIS_DIRECTORY)/repo/ bethselamin:/data/static-web/repo.holocm.org/archlinux/x86_64/

# These are the packages that I want.
build-packages: pkg-holo pkg-holo-build pkg-replicator

# the build rule for packages
pkg-%:
	@cd $* && perl ../build_package.pl $* $^
