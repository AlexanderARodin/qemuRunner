help:
	@cat Makefile

run:
	@echo 'run?'

edit:
	@echo 'edit?'


git.pushall: git.commitall
	@git push
git.commitall: git.addall
	@if [ -n "$(shell git status -s)" ] ; then git commit -m 'saving'; else echo '--- nothing to commit'; fi
git.addall:
	@git add .

clean:
	@echo 'clean?'
