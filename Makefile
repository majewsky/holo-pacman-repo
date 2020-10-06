create-repo:
	@art

pull-repo:
	@rsync -vau --delete-delay --progress bet:/var/lib/repo.holocm.org/archlinux/x86_64/ $(CURDIR)/repo/

push-repo: create-repo
	@rsync -vau --delete-delay --progress $(CURDIR)/repo/ bet:/var/lib/repo.holocm.org/archlinux/x86_64/
