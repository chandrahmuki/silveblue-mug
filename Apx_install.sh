#!/bin/bash

# Clone the repository
git clone --recursive https://github.com/Vanilla-OS/apx.git

# Enter the directory
cd apx

# Build apx
make

# Install the binary
make install PREFIX=$HOME/.local

# Check if the path is already in the PATH variable
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  # Add the path to the shell config file
  shell_config_file=""

  case $SHELL in
    *bash*)
      shell_config_file="$HOME/.bashrc"
      ;;
    *zsh*)
      shell_config_file="$HOME/.zshrc"
      ;;
    *fish*)
      shell_config_file="$HOME/.config/fish/config.fish"
      ;;
    *)
      echo "Unsupported shell. Please add the following line manually to your shell config file:"
      echo "export PATH=\$PATH:\$HOME/.local/bin:\$HOME/.local/share/apx/bin"
      exit 1
      ;;
  esac

  if [[ $SHELL == *fish* ]]; then
    echo "set -gx PATH \$PATH \$HOME/.local/bin \$HOME/.local/share/apx/bin" >> $shell_config_file
  else
    echo "export PATH=\$PATH:\$HOME/.local/bin:\$HOME/.local/share/apx/bin" >> $shell_config_file
  fi

  echo "Path added to $shell_config_file"
else
  echo "The path is already in your PATH variable."
fi