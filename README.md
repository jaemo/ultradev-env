ultradev-env
============

My dev setup for Rails, Ruby etc...
  
  Background:
    I was bored on labor day, so I decided to level up my development environment.
    I'd read about tmux and was curious to see how I could customize the shell to my liking.
    
Assumptions:
------------
  - You're running OSX 
  - You do a lot of work in the shell
  - You edit in vim
  - You use homebrew to manage installations on your machine
  - You want a way to streamline your work environment

  If any of the above are false, and you can't change things in your workflow to make them true,  you're probably wasting time here. 
  In *theory* this should also work on linux and other nixes, but I can't vouch for the accuracy of my instructons on those platforms.

Setup:
------
  You'll need to install the following 
  1. ZSH - brew install zsh
  2. iTerm2 - http://www.iterm2.com/#/section/home - I usually go with the beta, as it has a tmux with it
  3. get oh-my-zsh installed - git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh - this should set up your initial .zshrc file, you may have to add the code to run RVM as a binary. This would be in your .bash_profile (or wherever you are defining shell vars)
  4. install tmux, either brew install or use the version that came with iTerm2
  5. install powerline - https://github.com/erikw/tmux-powerline -> NB: this will require upgrading your bash install, regardless if bash is your shell of choice, so: 
    - brew install bash
    - edit either .profile or .bash_profile to make sure /usr/local/bin is at the start of your $PATH (yes, even if you are using zsh!)
    - quit terminal, reopen and check if bash --version is at least 4.2
  6. install the fonts 
  7. try starting up tmux:
     <pre>$ tmux</pre>
     from prompt. If it works, awesome move on, if not try quitting iterm and starting again
  8. You can either use the files included here to customize futher, or use the ones that came with your downloads/git repos.
  9. Spend the time learning how to use tmuxinator (https://github.com/aziz/tmuxinator#usage)
  10. Enjoy your badass ultradev env.  
