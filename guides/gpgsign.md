# Automatically sign your Git commits with GPG key

This is a getting started guide for using GPG to sign your commits.
It is a good practice to sign your commits with a GPG key to prevent others
to forge authenticity of your commits. This means that every commit you sign
with a GPG key, it wil unambiguously identify you as the author of a commit.

Just as in sending email it is really easy to fake your identity also
when commiting code:

```
git commit -a -m "Meh" --author "Chuck Norris <chuck@example.com>"
```

So in theory, this would allow anyone to commit (malicious) code under your
name. That will put you on the blame list for creating some back door "you"
commited.

GPG offers a solution to the problem of trust by using public keys to sign a git
commit in the same way you would sign your email.

## Setup for MacOS
If you dont have homebrew, go ahead and install it before you continue.

```
# Step 1
brew install gpg2

# Step 2
# Generate a GPG key pair
#
# You will be asked to enter your name, email address. Ensure the email address
# matches your GitHub email address if you want Github to show your commits as
# verified otherwise ignore this advice.
#
# To save your entry, type letter “O” and hit enter/return. You will be asking
# for a passphrase to continue. The passphrase will come in handy when signing
# your commits.
gpg2 --gen-key

# Step 3

# List your GPG key ID
gpg2 --list-secret-keys | grep ^sec
# Run the command below to output your GPG key, substituting in your GPG key ID.
gpg2 --armor --export [YOUR GPG KEY ID]

# Step 4
# Copy your GPG key, beginning with -----BEGIN PGP PUBLIC KEY BLOCK-----
# and ending with -----END PGP PUBLIC KEY BLOCK-----
# Login to your GitHub account. In the top right corner of any page, click your
# profile photo, then click Settings.
# Click SSH and GPG keys menu.


# Step 5
# Enable GPG signing for all commits by default and set your GPG signing key in
# Git versions 2.0.0 and above.
git config --global commit.gpgsign true
git config --global user.signingkey [YOUR GPG KEY ID]

# Step 6
# explicitly tell Git where to find GPG
git config --global gpg.program gpg2


# Step 7
# To store your GPG key passphrase so you don't have to enter it every time you
# sign a commit, we recommend using the following tools:
# For Mac users, the GPG Suite allows you to store your GPG key passphrase in
# the Mac OS Keychain.

# Step 8
# Trust your own key 

gpg2 --edit-key [YOUR GPG KEY ID]
# enter 'trust' and select 5 as a top trust level

```

## Signing commmits
```
git commit -S -m "Cool new feature"

# Git log doesn’t display signatures by default, but you can force it to with 
# the --show-signature option:

git log --show-signature

commit 223dadd342831acad9c2c88fc26260d297dfc514 (HEAD -> master)
gpg: Signature made Thu Jun  8 00:44:53 2017 CEST
gpg:                using RSA key B8772064565FC3AE
gpg: Good signature from "Sasa Macakanja <sasa.macakanja@gmail.com>" [ultimate]
Author: Sasa Macakanja <sasa.macakanja@gmail.com>
Date:   Thu Jun 8 00:43:18 2017 +0200

    Update readme
```
