#!/bin/zsh

print "\n# Language version -------------------------"

print "\n# nodejs version:"
node -v

print "\n# python version:"
python -V

print "\n# lua version:"
lua -v

print "\n# go version:"
go version

print "\n# R version:"
R --version

print "\n# kotlin version:"
kotlin -version

print "\n# php version:"
php -v

print "\n--------------------------------------------\n\n"


print "\n# Packages version -------------------------"

print "\n# asdf version:"
asdf version

print "\n# python packages of neovim environment:"
$HOME/.config/nvim/.venv/bin/pip3 list

print "\n# neovim version:"
nvim -v

print "\n # lazygit version:"
lazygit -v

print "\n--------------------------------------------\n\n"
