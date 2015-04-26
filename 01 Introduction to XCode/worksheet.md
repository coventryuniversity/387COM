# Introduction to XCode
## Worksheet

This lab is designed to take you through many of the key features of XCode which is the default Integrated Development Environment (IDE) for writing iOS apps. Don’t worry if you don’t understand many of the terms. Spend time finding your way around the XCode interface and ensure you understand the purpose behind the steps you carry out.

To complete this lab you will need to be running XCode 6 since we will be writing our code in the Swift programming language.

During this lab we will be building a shopping app called TODO which allows you to add and remove items from a shopping list at check items off as you buy them. All the graphical assets are available for you to use.

## Software Requirements

In order to complete this lab you will need access to a Mac computer running OS X 10.10 Yosemite and XCode 6. These are both free downloads from the Mac App Store.

## Regular Testing

The lab is broken down in a series of tasks. At the end of each task you should run your project in the simulator to ensure there are no build errors. The steps it takes you through are typical for all iOS projects.

So during this lab, make sure you remember to test everything after each step.

## Extension Activities

Once you have successfully completed the main lab tasks you are encouraged to have a go at the extension activities. These are slightly more challenging and will help your understanding of writing iOS apps.

# Accessing the Teaching Materials

All the materials used in this module, both worksheets and sample code, are available through GitHub. The repository is located at `https://github.com/covcom/387COM`. You will need to clone this to your Mac before starting the labs. If you are comfortable doing this you can skip the rest of this section.

## Cloning the Material

This will require you to use the *Terminal* app, located in the `Application/Utilities` folder on your Mac. If you have ever used *Linux* most of the commands we use will be familiar since OSX is a UNIX variant. Open up the Terminal app and navigate to the Documents directory using `cd Documents`. You can then clone the entire repository using `git clone https://github.com/covcom/387COM` which will download the repository to the documents directory and checkout the latest files for you to work with. You should find a directory called 387OCOM. Inside this there is a directory for each lab.

## Committing Your Changes

Whilst you can freely clone the supplied repository you won't be able to commit any of your work back to it. You will need to create your own repository if you wish to do this. It is recommended that you create a repository on BitBucket[1]. Start by creating an account on their website (use your personal email address for this) and logging in.

### Registering an SSH Key on BitBucket

You will need to register a SSH key if you want to push changes to the remote repository. The first step is to make sure there is a key generated on your local computer. Open the terminal app and type in the following command. This will copy the computer’s public key to the clipboard.

```
ssh-keygen
pbcopy < ~/.ssh/id_rsa.pub
```
After logging in, access the *account settings* using the dropdown menu in the top-right corner of the screen.

![Accessing account settings](images/01.png)

Make sure you add your photo and full name to this screen. Down the left-side of the screen there is a link to your SSH keys. Click on this to access the list of registered keys. You can now add your key by clicking on **Add Key** and pasting in the key from the clipboard. You will also need to add a label to this. If you are in the University lab you can use the unique machine ID on the sticker.

### Creating a New Repository

Return to the BitBucket home screen, click on the **Create** button at the top of the screen and choose *create a repository*. Give it the name *387COM* and make sure you choose the *Git* and not the *Mercurial* option. Choose the *Swift* language and then click on the **Create repository* button.

### Changing the Remote
You should be given the option to import an existing project. Clicking on the *I have an existing project* link should give you the commands you need to enter to push your local repository to your new remote. There is one change you will make to these instructions because you will already have a remote configured. See below for the detailed commands, remembering to substitute your repository URL where required.
```
git remote set-url origin git@bltbucket.org:[username]/387com.git
git push origin --all
git push origin --tags
```
You should now check on your BitBucket remote page that all commits are pushed.

### Pushing Changes
After completing an activity and before you leave the lab you need to make sure all local changes have been pushed to the remote. You will have already been taught this in previous modules so this should serve as a reminder.
```
git status
git add .
git status
git commit -m 'your commit message goes here'
git push origin master
```
Before logging off the Mac it is wise to check the BitBucket website to make sure your latest commit is safe.

### Working on a Different Mac
If you find yourself working on a different mac next lab session you will need to:

1. add the new Mac's public key
2. clone the repository to the new Mac

If you are using more than one Mac you should pull all changes from BitBucket before starting any work.
```
git pull
```
You are now ready to start learning iPhone Development.

[1] https://bitbucket.org/
