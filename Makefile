# The build process has two steps:
# 1. build all packages and copy them into the repo/ subdirectory
# 2. make a pacman repo in there
create-repo: build-packages
	@repo-add -n repo/holo.db.tar.xz repo/*.pkg.tar.xz
	@rm -f repo/holo.db.tar.xz.old
	@ln -sf holo.db repo/holo.files

# These are the packages that I want.
build-packages: pkg-holo pkg-holo-build pkg-holo-run-scripts pkg-holo-ssh-keys pkg-holo-users-groups

# These are dependencies between these packages.
pkg-holo-run-scripts: pkg-holo
pkg-holo-ssh-keys: pkg-holo
pkg-holo-users-groups: pkg-holo

# the build rule for packages
pkg-%:
	@cd $* && perl ../build_package.pl $* $^
