help:
	@cat Makefile

rescuer:
	@./scripts/rescuer.sh ./target/$(disk)

run:
	@./scripts/loadCoreInitrd.sh vmlinuz-buster64 dCore-buster64.gz

edit:
	@nvim scripts/loadCoreInitrd.sh

savetogit: git.pushall
git.pushall: git.commitall
	@git push
git.commitall: git.addall
	@if [ -n "$(shell git status -s)" ] ; then git commit -m 'saving'; else echo '--- nothing to commit'; fi
git.addall:
	@git add .

clean:
	@echo 'clean?'
