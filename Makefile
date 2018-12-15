create-repo:
	@art

pull-repo:
	@rsync -vau --delete-delay --progress bethselamin:/data/static-web/repo.holocm.org/archlinux/x86_64/ $(CURDIR)/repo/

push-repo: create-repo
	@rsync -vau --delete-delay --progress $(CURDIR)/repo/ bethselamin:/data/static-web/repo.holocm.org/archlinux/x86_64/
