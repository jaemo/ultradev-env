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


Setup:
------
  You'll need to install the following 
  1. ZSH - brew install zsh
  2. iTerm2 - http://www.iterm2.com/#/section/home - I usually go with the beta, as it has a tmux with it
  3. get oh-my-zsh installed - git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
  4. install tmux, either brew install or use the version that came with iTerm2
  5. install powerline - https://github.com/erikw/tmux-powerline -> NB: this will require upgrading your bash install so: 
    - brew install bash
    - edit either .profile or .bash_profile to make sure /usr/local/bin is at the start of your $PATH
    - quit terminal, reopen and check if bash --version is at least 4.2
  6. install the fonts 
  7.  
