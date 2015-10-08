<img align="right" src="labs/01 XCode/01 Introduction/images/uni_logo.png">
.

.
#387COM

Welcome to the first worksheet covering **iPhone Application Development**. You are probably viewing this via **GitHub** so one of the first tasks we will be carrying out is showing you how to fork your own copy of the code and maintain it on your own Git repository.

Before we get started it is worth reiterating that the module covers some advanced programming concepts which you will be required to demonstrate in your assignment which is entirely assessed through a practical coursework assignment. The module comprises eleven topics, each containing three worksheets. You will spend all semester *writing complex iPhone applications*.

You will be shown how to use an IDE called **XCode** to write iPhone apps using the **Swift** programming language. You *must* use this when writing your assignment.

# 1 Getting Started

## 1.1 Cloning the GitHub Repository

Start by opening the **Terminal** application on your Mac and navigating to your network drive. This can be found in the /Volumes directory and its name will match your username
```
cd /Volumes/
ls
Macintosh HD	username
cd username
ls
```
Next you need to clone the repository on GitHub, this contains the worksheets and code you will need to complete the module.
```
git clone https://github.com/covcom/387COM.git
```
By default your network drive won't appear in finder. We need to add this manually. Open **Finder** then, from the **Go** menu choose **Go to folder**. You need to access the `/Volumes` folder so enter the following and press enter.
```
/Volumes/
```
Finally, drag your network drive into the sidebar as shown.

<img align="right" src="labs/01 XCode/01 Introduction/images/finder.png">

You will now be able navigate to the 387COM directory and locate the projects you will be working on in the module.


## 1.2 Creating a New Repository

Now create an account and log into **BitBucket** (https://bitbucket.com). Create yourself a new empty repository by clicking on the **Create** button at the top of the page then choose **Create repository. In the *name* field you should enter **387COM** and in the *Description* field enter *iPhone App Development*. Check the *access level* to specify a private repository and click on **Create Project*. You will be taken to the project home screen.

On the home screen click on the **I'm starting from scratch** link. You should see a link similar to the one below. Copy this to your clipboard.
```
git@bitbucket.org:username/305cde.git
```
Now return to the Terminal app on your Mac, make sure you are in the root 387COM directory and check the current remote settings.
```
git remote -v
origin  https://github.com/covcom/387COM.git (fetch)
origin  https://github.com/covcom/387COM.git (push)
```
As you can see your workspace points to the readonly version on GitHub. Lets change this to point to our read-write repository on GitLab. Make sure you substitute your own URL.
```
git remote set-url origin git@bitbucket.org:username/305cde.git
git remote -v
origin  git@bitbucket.org:username/305cde.git (fetch)
origin  git@bitbucket.org:username/305cde.git (push)
```
You will notice that your remote called *origin* now points to your new BitBucket repository.

Finally we need to configure Git on your local machine with our name and email address. Make sure this matches the name and email you used when setting up your GitLab account.
```
git config --global user.name 'Your Name'
git config --global user.email 'your@email.com'
```

## 1.2 Configuring SSH Keys

You will need to add your Mac's **public key** to the BitBucket server before you will be able to push your changes. The first step is to make sure you have a public/private key pair on your development machine. Open the **Terminal** app and enter the following.
```
ls -a ~/.ssh
.		..		id_rsa     id_rsa.pub

```
Amongst the files you should see those listed in the above example. If these files do **not** exist you will need to run the following command to generate them. Make sure you enter the email address you used to register for your *BitBucket* account. The default options are fine so just press the *Enter* key until you are returned to the command prompt.
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Now we need to add these to **BitBucket**. First we copy the contents of the *public* key `id_rsa.pub` to the computer clipboard.
```
pbcopy < ~/.ssh/id_rsa.pub
```

<img align="right" src="labs/01 XCode/01 Introduction/images/manage_account.png">

Now open your BitBucket home screen and click on the **Profile** button (see screenshot) then select on the **Manage account** option located down the left-edge of the screen. You should see a tab down the left of the screen labelled **SSH Keys**. Click on this then click on the **Add key** button. Paste the contents of the clipboard into the **key** field and add a suitable **Label** and click on the green **Add SSH Key** button.

<img align="right" src="labs/01 XCode/01 Introduction/images/add_key.png">

## 1.3 Pushing to the New Remote

The final step is to push the local copy of your repository to the new *origin* remote. This will upload all the files and change history to your own remote on GitLab.
```
git push origin master
```
If you now open the *BitBucket* repository you will see a **files** link down the left-hand side of the screen. If you click on this you will see all the project files on your BitBucket repository.

## 1.4 Pulling Changes

Over the course of the module there will be changes made to the original read-only repository on GitHub. To allow access to these changes you will need to add a second remote to your local Cloud 9 repository (we will label this as the *upstream* repository).
```
git remote -v
git remote add upstream https://github.com/covcom/387COM.git
git remote -v
```
Before you start each worksheet take a few moments to sync your fork which will keep it up to date with the original.
```
git pull upstream master
```
This will pull down any new files or changes from the GitHub repository and merge them into your local copy. In this way you will always have the latest versions of the teaching materials.

## 1.5 Commiting Working Code

At the end of each exercise you should get into the habit of commiting your working code.
```
git status
git commit -a -m 'finished exercise xxxx'
```

## 1.6 Pushing to Your Remote

At the end of your programming session you should push all these new commits back to your GitLab repository.
```
git log origin/master..HEAD
git push origin --all
git log origin/master..HEAD
```

# Homework

Git is an important tool for any programmer and it is at the heart of what we do in this module. It is important that you become familiar with it by understanding how it works and practicing the core git commands.

Your homework is to read about the core Git concepts ready to answer questions in your second lab. You should read and understand the first two chapters from this free online book.

https://git-scm.com/book/en/v2

You can either read it online or download an ebook to install on your ebook reader, phone or tablet.