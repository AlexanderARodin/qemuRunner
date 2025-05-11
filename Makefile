help:
	@cat Makefile

rescuer:
	@./scripts/run_rescuer.sh ./target/$(disk)


run.test:
	@cd ../chrooter/ && make allin
	@./scripts/run_CoreInitrd.sh bzImage current-initrd.gz

run.core:
	@./scripts/run_CoreInitrd.sh boot/vmlinuz64 boot/corepure64.gz
run.dcore:
	@./scripts/run_CoreInitrd.sh boot/vmlinuz-buster64 boot/dCore-buster64.gz

edit:
	@nvim scripts/run_CoreInitrd.sh

savetogit: git.pushall
git.pushall: git.commitall
	@git push
git.commitall: git.addall
	@if [ -n "$(shell git status -s)" ] ; then git commit -m 'saving'; else echo '--- nothing to commit'; fi
git.addall:
	@git add .

clean:
	@echo 'clean?'
