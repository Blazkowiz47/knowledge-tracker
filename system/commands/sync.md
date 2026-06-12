# Command: /sync

Commit and push knowledge-base changes only.

## Steps

1. Run `git status --short` in the knowledge-base repository.
2. Stage only files inside the knowledge-base repository that belong to the current task.
3. Do not stage, commit, or push external project repositories.
4. If there are staged changes, create a compact commit message describing the memory, wiki, procedure, or command update.
5. Push the current branch to its configured remote.
6. If there are no changes, report that the knowledge base is already clean.
7. If commit or push fails, report the failure and leave the repository state clear.
