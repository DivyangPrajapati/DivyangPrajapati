# Managing Multiple GitHub and GitLab Accounts

## 1: Generate Separate SSH Keys for Each Account

Open **Git Bash** and run:

```bash
# GitHub personal
ssh-keygen -t ed25519 -C "personal_email@email.com" -f ~/.ssh/id_ed25519_github_persona

# GitHub work
ssh-keygen -t ed25519 -C "work_email@email.com" -f ~/.ssh/id_ed25519_github_work

# GitLab personal
ssh-keygen -t ed25519 -C "personal_email@email.com" -f ~/.ssh/id_ed25519_gitlab_personal

# GitLab work
ssh-keygen -t ed25519 -C "work_email@email.com" -f ~/.ssh/id_ed25519_gitlab_work
```

| Part | Meaning |
|------|---------|
| ssh-keygen | Generate SSH key pair |
| -t ed25519 | Type: Use ed25519 encryption | 
| -C "email" | Comment / Label: Label the key (GitHub email) |
| -f ~/.ssh/id_ed25519_github_personal | File: Save it in your .ssh folder |

### To view public key

    cat ~/.ssh/id_ed25519_github_personal.pub

## 2: Add the SSH Keys to the SSH Agent

Start the SSH agent and add all keys:

```bash
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519_github_personal
ssh-add ~/.ssh/id_ed25519_github_work
ssh-add ~/.ssh/id_ed25519_gitlab_personal
ssh-add ~/.ssh/id_ed25519_gitlab_work
```

### Check with 

    ssh-add -l

When you use SSH keys, each key can have a passphrase (like a password to unlock it).
If you don't use an agent, you'd have to re-enter the passphrase every single time you use Git

| Command | Meaning | Result |
|---------|---------|--------|
| eval "$(ssh-agent -s)" | Start the SSH agent | Runs background key manager |
| ssh-add ~/.ssh/id_ed25519_github_personal | Add your personal GitHub key | Loaded into memory |
| ssh-add -l |  (Optional) List keys added | Shows fingerprints of loaded keys |

## 3: Add Public Keys to Each Platform

### GitHub
- Go to: **Settings → SSH and GPG Keys → New SSH Key**
- Paste the content of the corresponding `.pub` file (e.g., `id_ed25519_github_personal.pub`).

### GitLab
- Go to: **select avatar → Edit Profile → SSH Keys**
- Paste the content of the corresponding `.pub` file.

## 4. Configure SSH for Multiple Accounts

Edit `~/.ssh/config` and add:

```bash
# ==== GITHUB ====
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github_personal

Host github.com-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_github_work

# ==== GITLAB ====
Host gitlab.com-personal
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab_personal

Host gitlab.com-work
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519_gitlab_work
```

## 5. Clone Repositories Using the Correct Host Alias

```bash
# GitHub
git clone git@github.com-personal:youruser/personal-repo.git
git clone git@github.com-work:company/work-repo.git

# GitLab
git clone git@gitlab.com-personal:youruser/personal-project.git
git clone git@gitlab.com-work:company/work-project.git
```

## 6. Set Git User Info per Repository

Inside each repo, set the right user identity:

```bash
git config user.name "Your Name"
git config user.email "your_email@example.com"
```